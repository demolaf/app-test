//
//  RepositoryProvider.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

class RepositoryProvider {
    static let shared = RepositoryProvider()

    let authRepository: AuthRepository
    let userRepository: UserRepository

    private init() {
        // External services
        let dataController = DataController(modelName: "CareSaasTest")
        dataController.load()
        let accessTokenManager = AccessTokenManagerImpl(userDefaults: UserDefaults.standard)
        let httpClient = HTTPClientImpl(urlSession: URLSession.shared, accessTokenManager: accessTokenManager)

        // Datasources interact with http client
        let authRemoteDatasource = AuthRemoteDatasourceImpl(httpClient: httpClient, accessTokenManager: accessTokenManager)
        let authLocalDatasource = AuthLocalDatasourceImpl(accessTokenManager: accessTokenManager)
        let userRemoteDatasource = UserRemoteDatasourceImpl(httpClient: httpClient)
        let userLocalDatasource = UserLocalDatasourceImpl(dataController: dataController)

        // Repositories interact only directly with Datasources
        authRepository = AuthRepositoryImpl(authRemoteDatasource: authRemoteDatasource, authLocalDatasource: authLocalDatasource, userLocalDatasource: userLocalDatasource)
        userRepository = UserRepositoryImpl(userRemoteDatasource: userRemoteDatasource, userLocalDatasource: userLocalDatasource)
    }
}
