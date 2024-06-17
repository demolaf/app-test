//
//  UserDatasource.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

protocol UserRemoteDatasource {
    func getUser(_ id: Int) async -> Result<UserDataResponse, NetworkError>
    func getAllUserTasks(by id: String) async -> Result<AllUserTasksResponse, NetworkError>
}

final class UserRemoteDatasourceImpl: UserRemoteDatasource {
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    let httpClient: HTTPClient

    func getUser(_ id: Int) async -> Result<UserDataResponse, NetworkError> {
        do {
            let data: UserDataResponse = try await httpClient.perform(UsersEndpoints.users(userId: id))
            return .success(data)
        } catch {
            if let error = error as? NetworkError {
                return .failure(error)
            }
            return .failure(NetworkError.unknown(message: error.localizedDescription))
        }
    }

    func getAllUserTasks(by id: String) async -> Result<AllUserTasksResponse, NetworkError> {
        do {
            let data: AllUserTasksResponse = try await httpClient.perform(TasksEndpoints.tasks(shortCode: "FKRC", careHomeId: "2", userId: id))
            return .success(data)
        } catch {
            if let error = error as? NetworkError {
                return .failure(error)
            }
            return .failure(NetworkError.unknown(message: error.localizedDescription))
        }
    }
}
