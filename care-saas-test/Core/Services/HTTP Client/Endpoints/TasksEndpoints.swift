//
//  TasksEndpoints.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

enum TasksEndpoints: NetworkRequest {
    case tasks(shortCode: String, careHomeId: String, userId: String)

    var path: String {
        switch self {
        case .tasks(let shortCode, let careHomeId, _):
            return "/v1/services/tasks/\(shortCode)/careHome/\(careHomeId)"
        }
    }

    var params: [String : Any] {
        switch self {
        case .tasks(_, _, let userId):
            [
                "userId": userId
            ]
        }
    }

    var addAuthorizationToken: Bool {
        false
    }

    var requestType: NetworkRequestType {
        switch self {
        case .tasks:
            NetworkRequestType.GET
        }
    }
}
