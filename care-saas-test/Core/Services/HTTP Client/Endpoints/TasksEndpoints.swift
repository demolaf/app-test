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
        case let .tasks(shortCode, careHomeId, _):
            return "/caresaas/v1/services/tasks/\(shortCode)/careHome/\(careHomeId)"
        }
    }

    var urlParams: [String : String?] {
        switch self {
        case let .tasks(_, _, userId):
            return [
                "assignee": userId
            ]
        }
    }

    var addAuthorizationToken: Bool {
        true
    }

    var requestType: NetworkRequestType {
        switch self {
        case .tasks:
            NetworkRequestType.GET
        }
    }
}
