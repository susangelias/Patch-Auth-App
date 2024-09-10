//
//  OtpEntryView.swift
//  patch_ios
//
//  Created by Susan Elias on 9/9/21.
//

import SwiftUI

public struct OtpEntryView: View {
    
    @ObservedObject var authViewModel: AuthViewModel

    var maxDigits: Int = 6
    
    @State var pin: String = ""
    @State var isDisabled = false
 
    var handler: (String, (Bool) -> Void) -> Void
    
    var alertOtpError: Alert {
        Alert(title: Text("Oops"), message: Text(authViewModel.otpErrorMessage), dismissButton: .default(Text("OK")) {
            authViewModel.otpErrorMessage = ""
            pin = ""
            isDisabled = false
        })
       }
    
    public var body: some View {
        VStack() {
            ZStack {
                pinDots
                backgroundField
            }
        }.alert(isPresented: $authViewModel.showOtpErrorMessage, content: { self.alertOtpError })
    }
    
    private var pinDots: some View {
        HStack {
            Spacer()
            ForEach(0..<maxDigits) { index in
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.patchColor.otpBkgnd)
                        .frame(width: 45, height: 45, alignment: .center)
                        .cornerRadius(4.0)
                    if let imageName = self.getImageName(at: index) {
                        Image(systemName: imageName)
                            .font(.system(size: 12, weight: .medium, design: .default))
                            .foregroundColor(Color.patchColor.otpDot)
                    }
                    if let pinText = self.getPinText(at: index) {
                        Text(pinText)
                            .fontWithLineHeight(font: UIFont(name: PatchFontName.InterSemiBold.rawValue, size: 24) ?? UIFont.systemFont(ofSize: 24), lineHeight: 36)
                            .foregroundColor(Color.patchColor.otpDot)
                    }
                }
            }
            Spacer()
        }
    }
    
    private var backgroundField: some View {
        let boundPin = Binding<String>(get: { self.pin }, set: { newValue in
            self.pin = newValue
            self.submitPin()
        })
        //  TBD: @FocusState in iOS 15 to allow keyboard to deploy when screen is displayed
        return TextField("", text: boundPin, onCommit: submitPin)
            .textContentType(.oneTimeCode)
            .accentColor(.clear)
            .foregroundColor(.clear)
            .keyboardType(.numberPad)
            .disabled(isDisabled)
    }

    private func submitPin() {
        guard !pin.isEmpty, !isDisabled else {
            return
        }
        
        if pin.count == maxDigits {
            isDisabled = true

            handler(pin) { isSuccess in
                if isSuccess {
                    print("pin matched, go to next page, no action to perfrom here")
                } else {
                    pin = ""
                    isDisabled = false
                    print("this has to called after showing toast why is the failure")
                }
            }
        }
        
        // this code is never reached under  normal circumstances. If the user pastes a text with count higher than the
        // max digits, we remove the additional characters and make a recursive call.
        if pin.count > maxDigits {
            pin = String(pin.prefix(maxDigits))
            submitPin()
        }
    }
    
    private func getImageName(at index: Int) -> String? {
        if index >= self.pin.count {
            return "circle.fill"
        }
        return nil
    }
    
    private func getPinText(at index: Int) -> String? {
        if index < self.pin.count {
            return self.pin.digits[index].numberString;
        }
       return nil
    }
}

extension String {
    
    var digits: [Int] {
        var result = [Int]()
        
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        
        return result
    }
    
}

extension Int {
    
    var numberString: String {
        
        guard self < 10 else { return "0" }
        
        return String(self)
    }
}

