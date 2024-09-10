//
//  Color+extensions.swift
//  patch_ios
//
//  Created by Susan Elias on 8/28/21.
//

import SwiftUI

extension Color {
   
    struct patchColor {
        static let primaryText = Color("TextColorPrimary")
        static let secondaryText = Color("TextColorSecondary")
        static let primaryAltText = Color.white
        static let secondaryAltText = Color("TextColorSoftWhite")
        
        static let primaryBkgnd = Color("BkgndColorPrimary")
        static let secondaryBkgnd = Color("BkgndColorSecondary")
        static let imageBkgnd = Color("BkgndHeroImage")
        
        static let otpBkgnd = Color("BkgndOtp")
        static let otpDot = Color("OtpDotColor")
        
        static let accentColor = Color("ButtonColor")
    }
}
