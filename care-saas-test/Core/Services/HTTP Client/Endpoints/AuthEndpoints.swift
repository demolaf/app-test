//
//  Endpoints.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

enum AuthEndpoints: NetworkRequest {
    case login(username: String, password: String)
    case verifyIdentity(userId: String, verificationCode: String)

    var path: String {
        switch self {
        case .login:
            "/caresaas/v1/services/auth/login"
        case .verifyIdentity(let userId, _):
            "/caresaas/v1/services/auth/\(userId)/verifyIdentity"
        }
    }

    var params: [String : Any] {
        switch self {
        case .login(let username, let password):
            [
                "userName": username,
                "password": password,
            ]
        case .verifyIdentity(_, let verificationCode):
            [
                "verificationCode": verificationCode
            ]
        }
    }

    var addAuthorizationToken: Bool {
        false
    }

    var requestType: NetworkRequestType {
        switch self {
        case .login:
            NetworkRequestType.POST
        case .verifyIdentity:
            NetworkRequestType.POST
        }
    }
}
