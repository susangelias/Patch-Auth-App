//
//  AuthenticationCoordinator.swift
//  patch_ios
//
//  Created by Susan Elias on 9/9/21.
//

import Foundation
import SwiftUI
import TwilioVerifySDK
import Apollo

enum AuthState {
    case unauth
    case otpEntry
    case otpValidated
    case waitingForPushChallenge
    case authenticated
}


class AuthViewModel: ObservableObject {

    static let patchAuthTokenKey = "patchAuthTokenKey"
    
    @Published var otpIsValid = false
    var otpErrorMessage = ""
    @Published var showOtpErrorMessage = false
    @Published var pushNotificationsAccepted = false
    @Published var authenticated = false
    @Published var showPushDeclinedAlert = false
    @Published var needValidationCode = true
    @Published var waitingForPushChallenge = false
    @Published var loading = false
    
    var deviceToken : String? {
        get {
            UserDefaults.standard.object(forKey: Constants.pushTokenKey) as? String
        }
    }
    
    var pushFactorPayload : PushFactorPayload?
    
    var verifyFactor : VerifyFactorPayload?
    
    var twilioVerify : TwilioVerify?
    
    var twilioAccessToken : String?
    
    var twilioFactor : Factor?
    
    var validateOtpResponse : ValidateOtpMutation.Data.ValidateOtp?
    
    var accessTokenResponse : GetTwilioAccessTokenMutation.Data.GetTwilioAccessToken?
    
    var authState : AuthState  {
        get {
            if isAuthenticated() {
                return .authenticated
            }
            if otpIsValid {
                return .otpValidated
            }
            if isRegisteredForPushNotifications {
              // return .pushNotificationsEnabled
            }
            if waitingForPushChallenge {
                return .waitingForPushChallenge
            }
            return .unauth
        }
    }
    
    init() {
        if let twilioVerifyAdapter = try? PatchVerifyAdapter() {
            twilioVerify = twilioVerifyAdapter
        }
    }

    public func isAuthenticated() -> Bool {
        // TBD -
        return false
    }

    func userEnteredOtp(otp: String, completion: @escaping (Bool, String?) -> ()) {
        
        DispatchQueue.main.async {
            self.promptUserForPushNotifications()
        }
                
        DispatchQueue.global(qos: .background).async { [ unowned self ] in

            self.loading = true
            
            self.validateOtp(otp: otp) { [ unowned self] error in
                
                if let otpPayload = self.validateOtpResponse, error == nil {
                    self.getVerifyAccessToken(patchAccessToken: otpPayload.token) { twilioAccessTokenResponse, error in
                    
                        if let tokenResponse = twilioAccessTokenResponse, error == nil {
                            self.createVerifyFactor( accessTokenResponse: tokenResponse, completion: { (twiloFactor, error) in
                                
                                if let factor = twiloFactor, error == nil {
                                    let payload = VerifyPushFactorPayload(sid: factor.sid)
                                    twilioVerify?.verifyFactor(withPayload: payload, success: { factor in
                                        print("\(factor)")
                                        self.waitingForPushChallenge = true
                                        self.loading = false
                                        
                                    }) { error in
                                        self.displayErrorString(message: error.localizedDescription)
            
                                    }
                                } else if let unwrappedError = error {
                                    self.displayErrorString(message: unwrappedError.localizedDescription)
                                }
                            })
                        } else if let unwrappedError = error {
                            self.displayErrorString(message: unwrappedError.localizedDescription)
                        }
                    }
                    if let unwrappedError = error {
                        self.displayErrorString(message: unwrappedError.localizedDescription)
                    }
                }
                if let unwrappedError = error {
                    self.displayErrorString(message: unwrappedError.localizedDescription)
                }
            }
        }
    }
}

//MARK: Push Notification Permissions
extension AuthViewModel {
    
    public var isRegisteredForPushNotifications : Bool {
        get {
            if let _ = UserDefaults.standard.object(forKey: Constants.pushTokenKey) as? String {
                return true
            }
            return false
        }
    }
    
    public var pushToken : String? {
        UserDefaults.standard.object(forKey: Constants.pushTokenKey) as? String
    }
    
    func promptUserForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (allowed, error) in
            if allowed == true {
                self.userAcceptedPushNotifications()
            } else {
                self.userDeclinedPushNotifications()
            }
        }
    }
    
    func userAcceptedPushNotifications() {
        pushNotificationsAccepted = true
        
    }
    
    func userDeclinedPushNotifications() {
        showPushDeclinedAlert = true
    }
    
    func displayErrorString( message : String ) {
        self.loading = false
        self.otpErrorMessage = message
        self.showOtpErrorMessage = true
    }
}

// MARK: - DGraph Network calls
extension AuthViewModel {
    
    func validateOtp(otp: String, completion: @escaping (Error?) -> () ) {
    
        Network.shared.apollo.perform(mutation: ValidateOtpMutation(code: otp), publishResultToStore: true, queue: DispatchQueue.main) { [unowned self] result in
            switch result {
            case .success(let graphQLResult):
                
                if let errors = graphQLResult.errors, let firstError = errors.first {
                    self.displayGraphQLError(errors: errors)
                    completion(firstError)
  
                } else {
                    self.validateOtpResponse = graphQLResult.data?.validateOtp
                    if let pToken = self.validateOtpResponse?.token {
                        AuthViewModel.updateStoredPatchToken(pToken)
                    }
                    completion(nil)
                }

            case .failure(let error):
                print("Validate OTP failure: \(error)")
                completion(error)
            }
        }
    }
    
    func getVerifyAccessToken( patchAccessToken : String, completion: @escaping (GetTwilioAccessTokenMutation.Data.GetTwilioAccessToken?, Error?) -> () ) {

        Network.shared.apollo.perform(mutation: GetTwilioAccessTokenMutation(), publishResultToStore: true, queue: DispatchQueue.main) { [unowned self] result in
            switch result {
            case .success(let graphQLResult):

                if let errors = graphQLResult.errors, let firstError = errors.first {
                    displayGraphQLError(errors: errors)
                    completion(nil, firstError)

                } else {
                    self.accessTokenResponse = graphQLResult.data?.getTwilioAccessToken
                    self.twilioAccessToken = graphQLResult.data?.getTwilioAccessToken?.token
                    completion(graphQLResult.data?.getTwilioAccessToken, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    fileprivate func displayGraphQLError(errors : Array<GraphQLError>) {
        let message = errors
              .map { $0.localizedDescription }
              .joined(separator: "\n")
        displayErrorString(message: message)
    }
}

// MARK: - Twilio SDK calls
extension AuthViewModel {

    func clearLocal() {
        if let patchAdapter = twilioVerify {
            do {
                try patchAdapter.clearLocalStorage()
            } catch {
                print("failed to clear storage")
            }
        }
    }
    
    func createVerifyFactor( accessTokenResponse: GetTwilioAccessTokenMutation.Data.GetTwilioAccessToken?, completion: @escaping (Factor?, Error?) -> ()  ) {
        
        guard let userId = accessTokenResponse?.identity, let unwrappedPushToken = deviceToken, let accessToken = twilioAccessToken, let serviceSID = accessTokenResponse?.serviceSid else {
            print("createVerifyFactor missing params")
           return
        }
   
        self.pushFactorPayload = PushFactorPayload(
            friendlyName: String(format: "%@", userId),
            serviceSid:  serviceSID,
            identity:  userId,
            pushToken: unwrappedPushToken,
            accessToken: accessToken
          )

        if let payload = self.pushFactorPayload, let patchAdapter = twilioVerify {

            patchAdapter.createFactor(withPayload: payload) { factor in
                print("created factor: \(factor)")
                completion(factor, nil)

            } failure: { error in
                self.displayErrorString(message: error.localizedDescription)
                completion(nil, error)
            }

        }
    }

}

// MARK: - secure data access
extension AuthViewModel {
    
    static func getStoredPatchToken() -> String {
      let kcw = KeychainWrapper()
      if let token = try? kcw.getGenericPasswordFor(
        account: Constants.patchKeystoreAccount,
        service: Constants.patchTokenKey) {
        return token
      }

      return ""
    }

    static func updateStoredPatchToken(_ token: String) {
      let kcw = KeychainWrapper()
      do {
        try kcw.storeGenericPasswordFor(
            account: Constants.patchKeystoreAccount,
          service: Constants.patchTokenKey,
          password: token)
      } catch let error as KeychainWrapperError {
        print("Exception setting patch token: \(error.message ?? "no message")")
      } catch {
        print("An error occurred setting the patch token.")
      }
    }

}

#if DEBUG
extension AuthViewModel{
   convenience init(forPreview: Bool = true)  {
      self.init()
    self.otpIsValid = true
   }
}
#endif

