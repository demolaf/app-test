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

    @Published var user: User?
    var cancellables = Set<AnyCancellable>()

    func initialize() {
        fetchUser()
        // fetchList()
    }

    private func fetchUser() {
        userRepository.getUser()
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
            }
            .store(in: &cancellables)
    }

    private func fetchList() {
        Task {
            await userRepository.getAllUserTasks()
        }
    }
}
