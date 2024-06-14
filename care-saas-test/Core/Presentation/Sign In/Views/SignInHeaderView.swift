//
//  SignInHeaderView.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 13/06/2024.
//

import SwiftUI

struct SignInHeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome back!👋")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(.appSecondary)
                Text("Fill your details to get started")
                    .font(.system(size: 16))
                    .foregroundStyle(.appSecondary)
            }
            Spacer()
        }
    }
}

#Preview {
    SignInHeaderView()
}
