//
//  LandingViewModel.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation
import Combine

final class LandingViewModel: ObservableObject {
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
        initialize()
    }

    private let authRepository: AuthRepository
    private var cancellableSet: Set<AnyCancellable> = []

    @Published var authenticated = false

    func initialize() {
        checkIfUserAuthenticated()
    }

    func checkIfUserAuthenticated() {
        let authenticated = authRepository.sessionExists()
        Just(authenticated)
            .receive(on: RunLoop.main)
            .assign(to: \.authenticated, on: self)
            .store(in: &cancellableSet)
        debugPrint("Authenticated \(authenticated)")
    }
}
