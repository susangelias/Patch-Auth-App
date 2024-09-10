//
//  patch_iosApp.swift
//  patch_ios
//
//  Created by Susan Elias on 8/25/21.
//

import SwiftUI
import os

@main
struct patch_iosApp: App {
   
    @StateObject var authViewModel = AuthViewModel()
    
    @StateObject private var notificationCenter = NotificationCenter()
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.patchColor.primaryBkgnd.edgesIgnoringSafeArea(.all)
                AuthRouter.init(viewModel: authViewModel).view(for: authViewModel.authState)
            }
            
        }

    }

}
