//
//  UserRepository.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation
import Combine

protocol UserRepository {
    func getUser() -> AnyPublisher<User, DatabaseError>
    func getAllUserTasks() async -> [String]
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

    func getUser() -> AnyPublisher<User, DatabaseError> {
        userLocalDatasource.getUser()
    }

    func getAllUserTasks() async -> [String] {
        // let result = userDatasource.getAllUserTasks()
        // switch result {
        // case .success(let response):
        //     return response.
        // case .failure(let failure):
        //     <#code#>
        // }
        return []
    }
}
