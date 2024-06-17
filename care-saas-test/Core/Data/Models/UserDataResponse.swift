//
//  UserDataResponse.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 17/06/2024.
//

import Foundation

struct UserDataResponse: Codable {
    let status: String
    let code: Int
    let message: String
    let data: [UserData]
}

struct UserData: Codable {
    let userId: Int
    let firstName, lastName, validFrom: String
    let gender, dateOfBirth: String
    let isActive: Bool

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case firstName, lastName, validFrom,  gender, dateOfBirth, isActive
    }
}

extension UserData {
    func toUserEntity() -> User {
        User(name: "\(firstName) \(lastName)")
    }
}
