//
//  SignInFormView.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 13/06/2024.
//

import SwiftUI

struct SignInFormView: View {
    @EnvironmentObject private var viewModel: SignInViewModel
    @Binding var goToHome: Bool

    var body: some View {
        VStack(spacing: 36) {
            VStack(spacing: 28) {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        FormField(
                            fieldValue: $viewModel.username,
                            fieldName: "Username"
                        )
                        if let isValid = viewModel.isUsernameValid {
                            if !isValid {
                                Text("Enter a valid username")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        FormField(
                            fieldValue: $viewModel.password,
                            fieldName: "Password",
                            isSecure: true
                        )
                        if let isValid = viewModel.isPasswordValid {
                            if !isValid {
                                Text("Enter a valid password")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
                HStack {
                    Toggle(isOn: $viewModel.isChecked) {
                        Text("Remember me")
                            .foregroundStyle(.appSecondary)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    Spacer()
                    Text("Forgot Password?")
                        .font(.system(size: 14))
                        .foregroundStyle(.red)
                }
            }
            VStack(spacing: 24) {
                Button {
                    print("Sign in button pressed")
                    viewModel.login()
                } label: {
                    if viewModel.authenticating {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity, maxHeight: 44)
                    } else {
                        Text("Sign in")
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity, maxHeight: 44)
                    }
                }
                .tint(.appPrimary)
                .buttonStyle(.borderedProminent)
                .disabled(!viewModel.isFormValid)
                Button {
                    print("No account tapped")
                } label: {
                    Group {
                        Text("Don’t have an account?")
                            .foregroundStyle(.appSecondary)
                        +
                        Text(" Contact Support")
                            .foregroundStyle(.appPrimary)
                    }
                    .tint(.primary)
                }
            }
        }
    }
}

#Preview {
    SignInFormView(
        goToHome: .constant(false)
    )
    .environmentObject(SignInViewModel(authRepository:  RepositoryProvider.shared.authRepository))
}
