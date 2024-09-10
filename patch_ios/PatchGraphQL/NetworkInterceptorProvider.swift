//
//  NetworkInterceptorProvider.swift
//  patch_ios
//
//  Created by Susan Elias on 10/30/21.
//

import Foundation
import Apollo

// Insert our interceptor with Patch auth token into the Apollo list of interceptors
class NetworkInterceptorProvider: DefaultInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(PatchAuthTokenInterceptor(), at: 0)
        return interceptors
    }
}

