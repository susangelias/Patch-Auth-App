//
//  PatchProgressView.swift
//  patch_ios
//
//  Created by Susan Elias on 11/9/21.
//

import SwiftUI

struct ActivityIndicatorView: View {
    
    @Binding var isPresented:Bool
    @State var statusText : String
    
    var body: some View {
        if isPresented{
            VStack{
                ProgressView(statusText)
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
    }
}


