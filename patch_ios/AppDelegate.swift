//
//  AppDelegate.swift
//  patch_ios
//
//  Created by Susan Elias on 9/1/21.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        initializeDeviceToken()

        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    
        let deviceTokenString = deviceToken.map { data in String(format: "%02.2hhx", data) }.joined()
        print("deviceToken: \(deviceTokenString)\n")

        let savedDeviceToken = UserDefaults.standard.object(forKey: Constants.pushTokenKey) as? String ?? String()
        
        if savedDeviceToken != deviceTokenString {
            UserDefaults.standard.set(deviceTokenString, forKey: Constants.pushTokenKey)
        }
        
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
 
        let alert = UIAlertController.init(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { alertAction in
            alert.dismiss(animated: true, completion: nil)
        }))
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)

    }

    private func initializeDeviceToken() {
        UIApplication.shared.registerForRemoteNotifications()
    }
}
