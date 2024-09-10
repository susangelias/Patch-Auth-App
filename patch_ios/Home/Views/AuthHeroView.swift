//
//  AuthHeroView.swift
//  patch_ios
//
//  Created by Susan Elias on 9/15/21.
//

import SwiftUI

struct AuthHeroView: View {
    var body: some View {
        VStack() {
            Image("Hero")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack() {
                ZStack(alignment: .center, content: {
                    Color.patchColor.imageBkgnd.edgesIgnoringSafeArea(.all)
                    PatchLogoView()
                        .scaleEffect(0.50, anchor: .center)
                    })
                .frame(width: .none, height: 74, alignment: .center)
                .cornerRadius(radius: 16, corners: [.bottomLeft, .bottomRight])
                .padding(EdgeInsets(top: -8, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}

struct AuthHeroView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeroView()
    }
}
