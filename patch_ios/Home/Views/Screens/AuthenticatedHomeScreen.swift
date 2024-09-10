//
//  AuthenticatedHomeScreen.swift
//  patch_ios
//
//  Created by Susan Elias on 9/12/21.
//

import SwiftUI

struct AuthenticatedHomeView: View {

    @ObservedObject var authViewModel: AuthViewModel
 
    var body: some View {
        ZStack {
            Color.patchColor.primaryBkgnd.edgesIgnoringSafeArea(.all)

            VStack() {
                AuthHeroView()
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                Text("WelcomeTitle")
                    .fontWithLineHeight(font: UIFont(name: PatchFontName.InterBold.rawValue, size: 24) ?? UIFont.systemFont(ofSize: 24), lineHeight: 36)
                    .foregroundColor(Color.patchColor.primaryAltText)
                    .padding(EdgeInsets(top: 8, leading: 20, bottom: 24, trailing: 20))
                    Text("WelcomeSubtitle")
                        .fontWithLineHeight(font: UIFont(name: PatchFontName.InterRegular.rawValue, size: 16) ?? UIFont.systemFont(ofSize: 16), lineHeight:18)
                        .foregroundColor(Color.patchColor.secondaryAltText)
                        .padding(EdgeInsets(top: 0, leading: 48, bottom: 0, trailing: 48))
                        .multilineTextAlignment(.center)
            }
        } .navigationBarBackButtonHidden(true)
    }
    
}

#if DEBUG
struct AuthenticatedHomeView_Previews: PreviewProvider {

    static var previews: some View {
        UIElementPreview(AuthenticatedHomeView(authViewModel: AuthViewModel(forPreview: true))
            .environment(\.colorScheme, .dark))
    }
}
#endif
