//
//  UnauthenticatedHomeView.swift
//  patch_ios
//
//  Created by Susan Elias on 9/8/21.
//

import SwiftUI

struct UnauthenticatedHomeView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack() {
                Color.patchColor.primaryBkgnd.edgesIgnoringSafeArea(.all)
                HStack() {
                    VStack() {
                        AccentViewLeading()
                        Spacer()
                    }
                    Spacer()
                }.edgesIgnoringSafeArea(.top)
                
                HStack() {
                    VStack() {
                        AccentViewArc()
                    }
                }.edgesIgnoringSafeArea(.top)
                
                HStack() {
                    Spacer()
                    VStack() {
                        AccentViewTrailing()
                    }
                }
                
                VStack() {
                    PatchLogoView().padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                    VStack(alignment:.leading) {
                        ImageParagraphView(imageName: "Shield", title: "SecurityTitle", subTitle: "SecuritySubtitle")
                            .padding(EdgeInsets(top: 0, leading: 12, bottom: 20, trailing: 12))

                        ImageParagraphView(imageName: "Device", title: "SetupTitle", subTitle: "SetupSubtitle")
                            .padding(EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12))
                        }
                    Spacer()
                    NavigationLink(destination: PatchAccountSetup(authViewModel: authViewModel)) {
                        Label("HomeScreenButtonTitle", systemImage: "")
                    }
                    .buttonStyle(PrimaryFilledButtonStyle())
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    Spacer()
                }
      
            }
        }.accentColor(.white)
    }

}

struct AccentViewLeading : View {
    var body: some View {
        if let imageName = UIImage.init(named: "rectRoundedLeading") {
            Image(uiImage: imageName)
        }
    }
}

struct AccentViewTrailing : View {
    var body: some View {
        if let imageName = UIImage.init(named: "roundedRectTrailing") {
            Image(uiImage: imageName)
        }
    }
}

struct AccentViewArc : View {
    var body: some View {
        if let imageName = UIImage.init(named: "arcColorDodge") {
            Image(uiImage: imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}

#if DEBUG
struct UnauthenticatedHomeView_Previews: PreviewProvider {

    static var previews: some View {
        UIElementPreview(UnauthenticatedHomeView(authViewModel: AuthViewModel(forPreview: true))
            .environment(\.colorScheme, .dark))
    
    }
}
#endif
