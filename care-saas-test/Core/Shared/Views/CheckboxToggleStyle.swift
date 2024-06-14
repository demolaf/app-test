//
//  CheckboxToggleStyle.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 13/06/2024.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .font(.system(size: 18))
                .foregroundStyle(.gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
                .padding(.trailing, 2)
            configuration.label
                .font(.system(size: 14))
        }
    }
}
