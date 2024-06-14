//
//  UserDatasource.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

protocol UserRemoteDatasource {
    func getAllUserTasks() async -> Result<AllUserTasksResponse, NetworkError>
}

final class UserRemoteDatasourceImpl: UserRemoteDatasource {
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    let httpClient: HTTPClient

    func getAllUserTasks() async -> Result<AllUserTasksResponse, NetworkError> {
        do {
            let data: AllUserTasksResponse = try await httpClient.perform(TasksEndpoints.tasks(shortCode: "FKRC", careHomeId: "2", userId: ""))
            return .success(data)
        } catch {
            if let error = error as? NetworkError {
                return .failure(error)
            }
            return .failure(NetworkError.unknown(message: error.localizedDescription))
        }
    }
}
