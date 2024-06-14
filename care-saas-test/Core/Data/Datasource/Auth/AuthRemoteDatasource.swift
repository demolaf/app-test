//
//  AuthDatasource.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation
import Combine

protocol AuthRemoteDatasource {
    func login (
        username: String,
        password: String
    ) async -> Result<LoginResponse, NetworkError>
}

final class AuthRemoteDatasourceImpl: AuthRemoteDatasource {
    init(httpClient: HTTPClient, accessTokenManager: AccessTokenManager) {
        self.httpClient = httpClient
        self.accessTokenManager = accessTokenManager
    }

    let httpClient: HTTPClient
    let accessTokenManager: AccessTokenManager

    func login(username: String, password: String) async -> Result<LoginResponse, NetworkError> {
        do {
            let data: LoginResponse = try await httpClient.perform(AuthEndpoints.login(username: username, password: password))
            try accessTokenManager.refreshWith(
                apiToken: APIToken(
                    tokenType: "Bearer",
                    expiresIn: 3600,
                    accessToken: data.data.userToken.accessToken,
                    refreshToken: data.data.userToken.refreshToken
                )
            )
            return .success(data)
        } catch {
            if let error = error as? NetworkError {
                return .failure(error)
            }
            return .failure(NetworkError.unknown(message: error.localizedDescription))
        }
    }
}
