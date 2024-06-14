//
//  LandingView.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import SwiftUI

struct LandingView: View {
    @EnvironmentObject private var viewModel: LandingViewModel

    var body: some View {
        if viewModel.authenticated {
            MainTabView()
        } else {
            SignInView()
        }
    }
}

#Preview {
    LandingView()
        .environmentObject(LandingViewModel(authRepository: RepositoryProvider.shared.authRepository))
}
