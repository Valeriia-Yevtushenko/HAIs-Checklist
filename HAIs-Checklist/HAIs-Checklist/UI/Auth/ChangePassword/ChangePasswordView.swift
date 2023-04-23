//
//  ChangePasswordView.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 04.03.2023.
//

import SwiftUI

struct ChangePasswordView: View {
    @SwiftUI.Environment(\.dismiss) var dismiss
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var confirmeNewPassword = ""
    @StateObject var viewModel: ChangePasswordViewModel
    @State private var error: String?
    
    init() {
        _viewModel = .init(wrappedValue: ChangePasswordViewModel())
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Зміна паролю")
                .font(.title)
                .foregroundColor(.black)
            if let error = error {
                HStack {
                    Spacer()
                    Text(error)
                    Spacer()
                }
                .padding(10)
                .background(.red)
                .cornerRadius(.pi)
                .padding(.bottom, 20)
            }
            PasswordSecureField(password: $oldPassword, placeholder: "Старий пароль")
            PasswordSecureField(password: $newPassword, placeholder: "Новий пароль")
            PasswordSecureField(password: $confirmeNewPassword, placeholder: "Повторіть новий пароль")
            changeButton
        }
        .padding(20)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity, alignment: .top)
        .foregroundColor(.black)
    }
}

private extension ChangePasswordView {
    var changeButton: some View {
        Button {
            Task {
                do {
                    try await viewModel.changePassword(oldPassword: oldPassword,
                                                       newPassword: newPassword,
                                                       confirmeNewPassword: confirmeNewPassword)
                    dismiss()
                } catch {
                    self.error = error.localizedDescription
                }
            }
        } label: {
            Text("Змінити")
                .frame(maxWidth: .infinity)
                .padding(10)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
