//
//  ContentView.swift
//  patch_ios
//
//  Created by Susan Elias on 8/25/21.
//

import SwiftUI

struct PatchAccountSetup: View {
  
    @ObservedObject var authViewModel: AuthViewModel
    @State var showPushNoteAlert = false
    @State var showLoadingSpinner = false
    
    var body: some View {
      
        ZStack() {
            Color.patchColor.primaryBkgnd.edgesIgnoringSafeArea(.all)
            
            // Push notifications declined alert
            .alert(isPresented: $showPushNoteAlert) {
                Alert(title: Text("NotificationsDeclineTitle"),
                    message: Text("NotificationsDeclineMessage"),
                    dismissButton: .default(Text("OK")))
            }
                    
            VStack() {
                HStack() {
                    Spacer()
                    AccentViewOTPTop()
                }
                Image("Profile")
                Text("AccountSetupTitle")
                    .padding()
                    .fontWithLineHeight(font: UIFont(name: PatchFontName.InterBold.rawValue, size: 24) ?? UIFont.systemFont(ofSize: 24), lineHeight: 24)
                    .foregroundColor(Color.patchColor.primaryText)
                    .multilineTextAlignment(.center)
                Text("AccountSetupOTPInstructions")
                    .padding()
                    .fontWithLineHeight(font: UIFont(name: PatchFontName.InterRegular.rawValue, size: 14) ?? UIFont.systemFont(ofSize: 14), lineHeight: 20)
                    .foregroundColor(Color.patchColor.secondaryText)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                OtpEntryView(authViewModel: authViewModel) { enteredOTP, finished in
                    authViewModel.userEnteredOtp(otp: enteredOTP) { otpIsValid, errorString in
                        if otpIsValid {
                            print("Validated OTP")
                        } else if let errorDescription = errorString {
                            print(errorDescription)
                        }
                    }
                }
                
                ActivityIndicatorView(isPresented: $authViewModel.loading, statusText: "Registering...")
                    .padding(EdgeInsets(top: 40, leading: 00, bottom: 0, trailing: 0))
                Spacer()
               
                HStack() {
                    Spacer()
                    AccentViewOTPBottom().ignoresSafeArea(.keyboard)
                }
                    
                NavigationLink(
                    destination: AuthRouter(viewModel: authViewModel).view(for: .authenticated),
                    isActive: $authViewModel.authenticated) { EmptyView() }
                }

        }.onReceive(authViewModel.$showPushDeclinedAlert) { wasDeclined in
            showPushNoteAlert = wasDeclined

        }
   
    }
}

struct AccentViewOTPTop : View {
     var body: some View {
         if let imageName = UIImage.init(named: "AccentOTPTop") {
             Image(uiImage: imageName)
                 .resizable()
                 .frame(width: 75.0, height: 75.0, alignment: .center)
                 .aspectRatio(contentMode: .fit)
         }
     }
 }

struct AccentViewOTPBottom : View {
     var body: some View {
         if let imageName = UIImage.init(named: "AccentOTPBottom") {
             Image(uiImage: imageName)
                 .resizable()
                 .frame(width: .infinity, height: 188.0, alignment: .center)
                 .aspectRatio(contentMode: .fit)
         }
     }
 }

#if DEBUG
struct PatchAccountSetup_Previews: PreviewProvider {
    static var previews: some View {
         UIElementPreview(PatchAccountSetup(authViewModel: AuthViewModel(forPreview: true)))
     }
}
#endif
