//
//  UserLocalDatasource.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation
import CoreData
import Combine

protocol UserLocalDatasource {
    func getUser() -> AnyPublisher<User, DatabaseError>

    @discardableResult
    func saveUser(user: User) -> Result<Bool, DatabaseError>
}

final class UserLocalDatasourceImpl: UserLocalDatasource {
    init(dataController: DataController) {
        self.dataController = dataController
    }

    let dataController: DataController

    func getUser() -> AnyPublisher<User, DatabaseError> {
        let request: NSFetchRequest<UserMO> = UserMO.fetchRequest()
        let context = dataController.viewContext

        return Future<User, DatabaseError> { promise in
            do {
                let userEntities = try context.fetch(request)
                if let user = userEntities.map({ $0.toUserEntity() }).first {
                    promise(.success(user))
                } else {
                    promise(.failure(.fetch))
                }
            } catch {
                promise(.failure(.fetch))
            }
        }
        .eraseToAnyPublisher()
    }

    func saveUser(user: User) -> Result<Bool, DatabaseError> {
        guard let context = dataController.backgroundContext else {
            return .failure(.save)
        }
        return context.performAndWait {
            do {
                let userMO = UserMO(context: context)
                userMO.userId = user.userId
                userMO.name = user.name
                userMO.email = user.email
                userMO.organization = user.organization
                try context.save()
                return .success(true)
            } catch {
                print("Failed to save todos to core data: \(error)")
                return .failure(.save)
            }
        }
    }
}
