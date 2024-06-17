//
//  HomeViewModel.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 13/06/2024.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    private let userRepository: UserRepository

    @Published var isLoading: Bool = false
    @Published var user: CurrentUser?
    @Published var tasks: [UserTask] = []
    var cancellables = Set<AnyCancellable>()

    func initialize() {
        fetchCurrentUser()
    }

    private func fetchCurrentUser() {
        isLoading = true
        userRepository.getCurrentUser()
            .receive(on: RunLoop.main)
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed to fetch user: \(error)")
                }
            } receiveValue: {[weak self] user in
                self?.user = user
                Task { [weak self] in
                    await self?.fetchList(userId: user.userId)
                }
            }
            .store(in: &cancellables)
    }

    @MainActor
    private func fetchList(userId: String) async {
        let result = await userRepository.getAllUserTasks(by: userId)
        switch result {
        case .success(let tasks):
            var updatedTasks: [UserTask] = []
            for task in tasks {
                var taskUpdated = task
                let userResult = await userRepository.getUser(task.userId)
                switch userResult {
                case .success(let user):
                    taskUpdated.userName = user.name
                case .failure(let failure):
                    debugPrint("Error fetching user by id: \(task.userId) \(failure)")
                }
                updatedTasks.append(taskUpdated)
            }
            self.tasks = updatedTasks
            isLoading = false
        case .failure(let failure):
            debugPrint("Error fetching tasks \(failure)")
        }
    }
}
