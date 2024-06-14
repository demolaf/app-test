//
//  AccessTokenManager.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

protocol AccessTokenManager {
    func isTokenValid() -> Bool
    func fetchToken() -> String
    func refreshWith(apiToken: APIToken) throws
}

class AccessTokenManagerImpl: AccessTokenManager {
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        update()
    }

    private let userDefaults: UserDefaults
    private var accessToken: String?
    private var expiresAt = Date()

    func isTokenValid() -> Bool {
        update()
        return accessToken != nil && expiresAt.compare(Date()) == .orderedDescending
    }

    func fetchToken() -> String {
        guard let token = accessToken else {
            return ""
        }
        return token
    }

    func refreshWith(apiToken: APIToken) throws {
        let expiresAt = apiToken.expiresAt
        let token = apiToken.bearerAccessToken

        save(token: apiToken)
        self.expiresAt = expiresAt
        self.accessToken = token
    }

    func save(token: APIToken) {
        userDefaults.set(token.expiresAt.timeIntervalSince1970, forKey: AppUserDefaultsKeys.expiresAt)
        userDefaults.set(token.bearerAccessToken, forKey: AppUserDefaultsKeys.bearerAccessToken)
    }

    func getExpirationDate() -> Date {
        Date(timeIntervalSince1970: userDefaults.double(forKey: AppUserDefaultsKeys.expiresAt))
    }

    func getToken() -> String? {
        userDefaults.string(forKey: AppUserDefaultsKeys.bearerAccessToken)
    }

    func update() {
        accessToken = getToken()
        expiresAt = getExpirationDate()
    }
}
