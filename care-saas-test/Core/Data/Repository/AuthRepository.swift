//
//  AuthRepository.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation
import Combine

protocol AuthRepository {
    func login(username: String, password: String) async -> Result<Bool, NetworkError>

    func sessionExists() -> Bool
}

final class AuthRepositoryImpl: AuthRepository {
    init(
        authRemoteDatasource: AuthRemoteDatasource,
        authLocalDatasource: AuthLocalDatasource,
        userLocalDatasource: UserLocalDatasource
    ) {
        self.authRemoteDatasource = authRemoteDatasource
        self.authLocalDatasource = authLocalDatasource
        self.userLocalDatasource = userLocalDatasource
    }

    let authRemoteDatasource: AuthRemoteDatasource
    let authLocalDatasource: AuthLocalDatasource
    let userLocalDatasource: UserLocalDatasource

    func login(username: String, password: String) async -> Result<Bool, NetworkError> {
        let result = await authRemoteDatasource.login(username: username, password: password)
        switch result {
        case .success(let data):
            userLocalDatasource.saveCurrentUser(data.data.user.toCurrentUserEntity())
            return .success(true)
        case .failure(let failure):
            return .failure(failure)
        }
    }

    func sessionExists() -> Bool {
        authLocalDatasource.sessionExists()
    }
}
