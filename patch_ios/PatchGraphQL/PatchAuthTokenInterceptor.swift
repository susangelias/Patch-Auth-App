//
//  TokenInterceptor.swift
//  patch_ios
//
//  Created by Susan Elias on 10/30/21.
//

import Foundation
import Apollo

class PatchAuthTokenInterceptor: ApolloInterceptor {
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
            let token = AuthViewModel.getStoredPatchToken()
            request.addHeader(name: "X-Auth-Token", value: token)
           // } // else do nothing
                    
            chain.proceedAsync(request: request,
                               response: response,
                               completion: completion)


    }
}

