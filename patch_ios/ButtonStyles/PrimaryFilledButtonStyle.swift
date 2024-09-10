//
//  PrimaryFilledButtonStyle.swift
//  patch_ios
//
//  Created by Susan Elias on 9/9/21.
//

import SwiftUI

struct PrimaryFilledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 50)
            .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
            .background(Color.patchColor.accentColor)
            .foregroundColor(Color.patchColor.primaryText)
            .cornerRadius(8.0)
    }
}


