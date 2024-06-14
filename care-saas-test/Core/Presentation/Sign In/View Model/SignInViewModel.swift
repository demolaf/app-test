//
//  SignInViewModel.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 13/06/2024.
//

import Foundation
import Combine

final class SignInViewModel: ObservableObject {
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
        initialize()
    }

    private let authRepository: AuthRepository
    private var cancellableSet: Set<AnyCancellable> = []

    @Published var authenticating = false
    @Published var authenticated = false
    @Published var failed = false
    @Published var failureMessage = ""
    @Published var username = ""
    @Published var password = ""
    @Published var isChecked = false
    @Published var isUsernameValid: Bool?
    @Published var isPasswordValid: Bool?
    @Published var isFormValid: Bool = false

    private func initialize() {
        initializeFormValidation()
    }

    private func initializeFormValidation() {
        validateUsername()
        validatePassword()
        validateForm()
    }

    private func validateUsername() {
        $username
            .receive(on: RunLoop.main)
            .drop { $0.isEmpty }
            .map { username in
                return !username.isEmpty
            }
            .assign(to: \.isUsernameValid, on: self)
            .store(in: &cancellableSet)
    }

    private func validatePassword() {
        $password
            .receive(on: RunLoop.main)
            .drop { $0.isEmpty }
            .map { password in
                return !password.isEmpty
            }
            .assign(to: \.isPasswordValid, on: self)
            .store(in: &cancellableSet)
    }

    private func validateForm() {
        Publishers.CombineLatest($isUsernameValid, $isPasswordValid) .receive(on: RunLoop.main)
            .map { (isUsernameValid, isPasswordValid) in
                guard let isUsernameValid, let isPasswordValid else {
                    return false
                }
                return isUsernameValid && isPasswordValid
            }
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellableSet)
    }

    func login() {
        authenticating = true
        Task {
            debugPrint("Username: \(username), Password: \(password)")
            let result = await authRepository.login(username: username, password: password)
            Just(result)
                .receive(on: RunLoop.main)
                .map {[weak self] result in
                    guard let self = self else { return false }
                    switch result {
                    case .success:
                        debugPrint("Success authenticating")
                        return true
                    case .failure(let failure):
                        debugPrint("Error authenticating \(failure)")
                        authenticating = false
                        failed = true
                        failureMessage = "Failed to authenticate"
                        return false
                    }
                }
                .assign(to: \.authenticated, on: self)
                .store(in: &cancellableSet)
        }
    }
}


