//
//  SignInView.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 13/06/2024.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject private var viewModel: SignInViewModel
    @Environment(\.dismiss) var dismiss
    @State private var goToHome = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack(spacing: 56) {
                    SignInHeaderView()
                    SignInFormView(goToHome: $goToHome)
                }
                Spacer()
                SignInFooterView()
            }
            .padding(.horizontal, 16)
            .alert("Error", isPresented: $viewModel.failed) {
                Button {
                    dismiss()
                } label: {
                    Text("Close")
                        .foregroundStyle(.red)
                }
            } message: {
                Text(viewModel.failureMessage)
            }
            .navigationDestination(isPresented: $viewModel.authenticated) {
                MainTabView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    SignInView()
        .environmentObject(SignInViewModel(authRepository:  RepositoryProvider.shared.authRepository))
}
