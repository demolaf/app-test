//
//  SignInFooterView.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 13/06/2024.
//

import SwiftUI

struct SignInFooterView: View {
    var body: some View {
        Group {
            Text("By clicking ‘Sign in’ above you agree to Arocare’s ")
                .foregroundStyle(.appSecondary)
            +
            Text("Terms & Conditions ")
                .foregroundStyle(.appPrimary)
            +
            Text("and ")
                .foregroundStyle(.appSecondary)
            +
            Text("Privacy Policy")
                .foregroundStyle(.appPrimary)
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    SignInFooterView()
}
