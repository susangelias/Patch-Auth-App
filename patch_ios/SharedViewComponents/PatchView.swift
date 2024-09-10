//
//  PatchView.swift
//  patch_ios
//
//  Created by Susan Elias on 9/11/21.
//

import SwiftUI

struct PatchView<Router: Routing>: View where Router.Route == AppRoute {
    let router: Router

    var body: some View {
        NavigationView {
          VStack {
//            Button("Go to ViewB") {
//              doSomethingAsync() {
//                self.navigateToViewB = true
//              }
//            }
     
//            NavigationLink(
//              destination: router.view(for: .viewB),
//              isActive: $navigateToViewB,
//              label: {
//                EmptyView()
//              }
//            )
 //         }
        }
      }
    }
}

//struct PatchView_Previews: PreviewProvider {
//    static var previews: some View {
//        PatchView()
//    }
//}

