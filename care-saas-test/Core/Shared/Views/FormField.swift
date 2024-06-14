//
//  FormField.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 13/06/2024.
//

import SwiftUI

struct FormField: View {
    @Binding var fieldValue: String
    @State private var obscured = true

    let fieldName: String
    var isSecure: Bool = false

    var body: some View {
        if isSecure {
            HStack {
                if obscured {
                    SecureField(fieldName, text: $fieldValue)
                        .font(.system(size: 13))
                        .frame(height: 24)
                } else {
                    TextField(fieldName, text: $fieldValue)
                        .font(.system(size: 13))
                        .frame(height: 24)
                }
                Button {
                    obscured.toggle()
                } label: {
                    Image(systemName: obscured ? "eye.slash" : "eye")
                        .font(.system(size: 16))
                        .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 12)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.appTextFieldBorder, lineWidth: 1)
            }
        } else {
            TextField(fieldName, text: $fieldValue)
                .font(.system(size: 13))
                .textInputAutocapitalization(.never)
                .frame(height: 24)
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.appTextFieldBorder, lineWidth: 1)
                }
        }
    }

    @ViewBuilder
    var formStyled: some View {
        if isSecure {
            HStack {
                SecureField(fieldName, text: $fieldValue)
                    .font(.system(size: 13))
                Button {
                    obscured.toggle()
                } label: {
                    Image(systemName: obscured ? "eye" : "eye.slash")
                        .font(.system(size: 16))
                        .foregroundStyle(.gray)
                }
            }
        } else {
            TextField(fieldName, text: $fieldValue)
                .textInputAutocapitalization(.never)
                .font(.system(size: 13))
        }
    }

    @ViewBuilder
    var customFormField: some View {
        if isSecure {
            HStack {
                SecureField(fieldName, text: $fieldValue)
                    .font(.system(size: 13))
                    .frame(height: 24)
                Button {
                    obscured.toggle()
                } label: {
                    Image(systemName: obscured ? "eye" : "eye.slash")
                        .font(.system(size: 16))
                        .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 12)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.appTextFieldBorder, lineWidth: 1)
            }
        } else {
            TextField(fieldName, text: $fieldValue)
                .font(.system(size: 13))
                .frame(height: 24)
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.appTextFieldBorder, lineWidth: 1)
                }
        }
    }
}

#Preview {
    FormField(
        fieldValue: .constant("demolaf"),
        fieldName: "username",
        isSecure: false
    )
}
