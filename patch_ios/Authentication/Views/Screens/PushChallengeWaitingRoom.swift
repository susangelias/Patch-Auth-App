//
//  PushChallengeLobby.swift
//  patch_ios
//
//  Created by Susan Elias on 11/9/21.
//

import SwiftUI

struct PushChallengeWaitingRoom: View {
    
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        Text("User and device are registered.\n\nWaiting to receive push notification to complete authentication")
            .multilineTextAlignment(.center)
    }
}

struct PushChallengeLobby_Previews: PreviewProvider {
    static var previews: some View {
        UIElementPreview(PushChallengeWaitingRoom(authViewModel: AuthViewModel(forPreview: true)))
    }
}
