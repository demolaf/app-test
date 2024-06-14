//
//  PrimaryButtonStyle.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 13/06/2024.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tint(.appPrimary)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
    }
}
