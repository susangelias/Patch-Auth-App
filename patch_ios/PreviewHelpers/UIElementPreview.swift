//
//  File.swift
//  patch_ios
//
//  Created by Susan Elias on 9/8/21.
//

import SwiftUI

struct UIElementPreview<Value: View>: View {

    private let dynamicTypeSizes: [ContentSizeCategory] = [.extraSmall, .large, .extraExtraExtraLarge]

    /// Filter out "base" to prevent a duplicate preview.
    private let localizations = Bundle.main.localizations.map(Locale.init).filter { $0.identifier != "base" }

    private let viewToPreview: Value

    init(_ viewToPreview: Value) {
        self.viewToPreview = viewToPreview
    }

    var body: some View {
        Group {
            self.viewToPreview
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .previewDisplayName("Default preview 1")

            self.viewToPreview
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")
 
            self.viewToPreview
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
                .previewDisplayName("iPhone SE")
            
            self.viewToPreview
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
                .previewDisplayName("iPhone 12 Mini")
            
            self.viewToPreview
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
                .previewDisplayName("iPhone 12 Pro Max")

//            ForEach(localizations, id: \.identifier) { locale in
//                self.viewToPreview
//                    .previewLayout(PreviewLayout.sizeThatFits)
//                    .padding()
//                    .environment(\.locale, locale)
//                    .previewDisplayName(Locale.current.localizedString(forIdentifier: locale.identifier))
//            }

//            ForEach(dynamicTypeSizes, id: \.self) { sizeCategory in
//                self.viewToPreview
//                    .previewLayout(PreviewLayout.sizeThatFits)
//                    .padding()
//                    .environment(\.sizeCategory, sizeCategory)
//                    .previewDisplayName("\(sizeCategory)")
//            }

        }
    }
}
