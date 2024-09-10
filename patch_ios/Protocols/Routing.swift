//
//  RouterProtocol.swift
//  patch_ios
//
//  Created by Susan Elias on 9/11/21.
//

import SwiftUI

protocol Routing {
  associatedtype AppRoute
  associatedtype View: SwiftUI.View
 
  @ViewBuilder func view(for route: AppRoute) -> Self.View
}
