//
//  LoginResponse.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

struct LoginResponse: Codable {
    let status: String
    let code: Int
    let message: String
    let data: LoginResponseData
}

// MARK: - LoginResponse
struct LoginResponseData: Codable {
    let user: LoginUser
    let userToken: UserToken
}

// MARK: - User
struct LoginUser: Codable {
    let sub: String
    let emailVerified: Bool
    let realmAccess: RealmAccess
    let name, preferredUsername, givenName, userId: String
    let familyName, email, organization: String
    let careHome: String?

    enum CodingKeys: String, CodingKey {
        case sub
        case emailVerified = "email_verified"
        case realmAccess = "realm_access"
        case name
        case preferredUsername = "preferred_username"
        case givenName = "given_name"
        case userId = "userId"
        case familyName = "family_name"
        case email, organization, careHome
    }
}

// MARK: - RealmAccess
struct RealmAccess: Codable {
    let roles: [String]
}

// MARK: - UserToken
struct UserToken: Codable {
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

extension LoginUser {
    func toUserEntity() -> User {
        User(
            userId: userId,
            name: name,
            email: email,
            organization: organization
        )
    }
}
