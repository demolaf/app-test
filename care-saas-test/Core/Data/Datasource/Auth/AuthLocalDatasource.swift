//
//  AuthLocalDatasource.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

protocol AuthLocalDatasource {
    func sessionExists() -> Bool
}

final class AuthLocalDatasourceImpl: AuthLocalDatasource {
    init(accessTokenManager: AccessTokenManager) {
        self.accessTokenManager = accessTokenManager
    }

    let accessTokenManager: AccessTokenManager

    func sessionExists() -> Bool {
        accessTokenManager.isTokenValid()
    }
}
