//
//  PrimaryBorderButtonStyle.swift
//  patch_ios
//
//  Created by Susan Elias on 9/13/21.
//

import SwiftUI

struct PrimaryBorderButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 50)
            .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
            .background(Color.clear)
            .foregroundColor(Color.patchColor.accentColor)
            .cornerRadius(8.0)
            .accentColor(Color.patchColor.accentColor)
            .border(Color.clear, width: 1)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.patchColor.accentColor, lineWidth: 1)
        )
    }
}

