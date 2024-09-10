//
//  ImageParagraphView.swift
//  patch_ios
//
//  Created by Susan Elias on 9/8/21.
//

import SwiftUI

struct ImageParagraphView: View {
    var imageName: String
    var title: LocalizedStringKey
    var subTitle: LocalizedStringKey
    var body: some View {
            
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25, alignment: .center)
            VStack(alignment: .leading, spacing: 12, content: {
                    Text(title)
                        .fontWithLineHeight(font: UIFont(name: PatchFontName.InterSemiBold.rawValue, size: 16) ?? UIFont.systemFont(ofSize: 16), lineHeight: 20)
                        .foregroundColor(Color.patchColor.primaryText)
                    Text(subTitle)
                        .fontWithLineHeight(font: UIFont(name: PatchFontName.InterRegular.rawValue, size: 14) ?? UIFont.systemFont(ofSize: 16), lineHeight: 20)
                        .foregroundColor(Color.patchColor.secondaryText)
            })
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct ImageParagraphView_Previews: PreviewProvider {

    static var previews: some View {
        ImageParagraphView(imageName: "Shield", title: "SecurityTitle", subTitle: "SecuritySubtitle")
            .environment(\.colorScheme, .light)
        ImageParagraphView(imageName: "Device", title: "SetupTitle", subTitle: "SetupSubtitle")
            .environment(\.colorScheme, .light)
    }
}
