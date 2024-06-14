//
//  CareSaasApp.swift
//  CareSaasApp
//
//  Created by Ademola Fadumo on 13/06/2024.
//

import SwiftUI

@main
struct CareSaasApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LandingViewModel(authRepository: RepositoryProvider.shared.authRepository))
                .environmentObject(SignInViewModel(authRepository: RepositoryProvider.shared.authRepository))
                .environmentObject(HomeViewModel(userRepository: RepositoryProvider.shared.userRepository))
        }
    }
}
