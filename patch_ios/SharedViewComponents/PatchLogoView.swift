//
//  PatchLogoView.swift
//  patch_ios
//
//  Created by Susan Elias on 9/13/21.
//

import SwiftUI

struct PatchLogoView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 12) {

            Image("PatchLogo")
                .frame(width: 37.5, height: 37.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text("PatchLogoText")
                .font(.custom(PatchFontName.InterBlack.rawValue, size: 36))
                .foregroundColor(Color.patchColor.primaryText)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .minimumScaleFactor(0.50)
        }
    }
}

struct PatchLogoView_Previews: PreviewProvider {
    static var previews: some View {
        PatchLogoView()
    }
}
