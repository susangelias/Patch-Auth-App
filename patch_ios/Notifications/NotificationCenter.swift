//
//  NotificationCenter.swift
//  patch_ios
//
//  Created by Susan Elias on 9/1/21.
//

import Foundation
import SwiftUI

class NotificationCenter: NSObject, ObservableObject {
    @Published var verifyPushChallenge: TwilioVerifyPushChallenge?
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
}

extension NotificationCenter: UNUserNotificationCenterDelegate  {

    // Background
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
      defer { completionHandler() }

      guard response.actionIdentifier == UNNotificationDefaultActionIdentifier else {
        return
      }
      let userInfo = response.notification.request.content.userInfo
        
        if let patchAuthNote = unpackPushNotification(userInfo: userInfo) {
            print(patchAuthNote)
            verifyPushChallenge = patchAuthNote
        }
        

    }

    // Foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      
        let userInfo = notification.request.content.userInfo

        if let patchAuthNote = unpackPushNotification(userInfo: userInfo) {
            print(patchAuthNote)
            verifyPushChallenge = patchAuthNote
            
        } else {
            completionHandler(UNNotificationPresentationOptions(rawValue: 0))
        }

      completionHandler(.sound)
    }
 
    fileprivate func unpackPushNotification(userInfo : [AnyHashable : Any]) -> TwilioVerifyPushChallenge? {
        
        if let aps = userInfo["aps"] as? [String : String] {
            if let category = aps["category"], category == "verify_push_challenge" {
              guard let challengeSid = userInfo["challenge_sid"] as? String,
                    let factorSid = userInfo["factor_sid"] as? String,
                    let type = userInfo["type"] as? String

               else {
                return nil
              }
   
            return TwilioVerifyPushChallenge(challengeSid: challengeSid,
                                                factorSid: factorSid,
                                                type: type)
            }
        }
        return nil
    }

}
