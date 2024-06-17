//
//  UserRepository.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation
import Combine

protocol UserRepository {
    func getUser(_ id: Int) async -> Result<User, NetworkError>
    func getCurrentUser() -> AnyPublisher<CurrentUser, DatabaseError>
    func getAllUserTasks(by id: String) async -> Result<[UserTask], NetworkError>
}

final class UserRepositoryImpl: UserRepository {
    init(
        userRemoteDatasource: UserRemoteDatasource,
        userLocalDatasource: UserLocalDatasource
    ) {
        self.userRemoteDatasource = userRemoteDatasource
        self.userLocalDatasource = userLocalDatasource
    }

    let userRemoteDatasource: UserRemoteDatasource
    let userLocalDatasource: UserLocalDatasource

    func getCurrentUser() -> AnyPublisher<CurrentUser, DatabaseError> {
        userLocalDatasource.getCurrentUser()
    }

    func getAllUserTasks(by id: String) async -> Result<[UserTask], NetworkError> {
        let result = await userRemoteDatasource.getAllUserTasks(by: id)
        switch result {
        case .success(let response):
            let tasks = response.data.compactMap { $0.toTaskEntity() }
            return .success(tasks)
        case .failure(let failure):
            return .failure(failure)
        }
    }

    func getUser(_ id: Int) async -> Result<User, NetworkError> {
        let result = await userRemoteDatasource.getUser(id)
        switch result {
        case .success(let response):
            let user = response.data.first?.toUserEntity()
            if let user = user {
                return .success(user)
            }
            return .failure(.invalidServerResponse)
        case .failure(let failure):
            return .failure(failure)
        }
    }
}
