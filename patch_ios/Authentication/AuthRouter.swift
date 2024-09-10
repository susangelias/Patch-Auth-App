//
//  AuthRouter.swift
//  patch_ios
//
//  Created by Susan Elias on 9/11/21.
//

import SwiftUI


// Construct views with dependencies for the given context
struct AuthRouter: Routing {
    
    typealias AppRoute = AuthState
    
    @ObservedObject var viewModel : AuthViewModel

    func view(for route: AppRoute) -> some View {
    switch route {
        case .unauth:
            UnauthenticatedHomeView(authViewModel: viewModel)
     
        case .otpEntry, .otpValidated:
            PatchAccountSetup(authViewModel: viewModel)
            
        case .waitingForPushChallenge:
            PushChallengeWaitingRoom(authViewModel: viewModel)
        
        case  .authenticated:
            AuthenticatedHomeView(authViewModel: viewModel)
    
        }
  }
}
