//
//  UsersEndpoints.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 17/06/2024.
//

import Foundation

enum UsersEndpoints: NetworkRequest {
    case users(userId: Int)
    case personalContacts(userId: Int)

    var path: String {
        switch self {
        case .users:
            return "/caresaas/v1/services/users"
        case .personalContacts(let userId):
            return "/caresaas/v1/services/users/\(userId)/personalContacts"
        }
    }

    var urlParams: [String : String?] {
        switch self {
        case .users(let userId):
            return [
                "userType": "serviceUser",
                "userId": String(userId)
            ]
        case .personalContacts:
            return [:]
        }
    }

    var addAuthorizationToken: Bool {
        true
    }

    var requestType: NetworkRequestType {
        switch self {
        case .users:
            NetworkRequestType.GET
        case .personalContacts:
            NetworkRequestType.GET
        }
    }
}
