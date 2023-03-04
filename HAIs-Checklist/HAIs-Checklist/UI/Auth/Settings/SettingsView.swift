//
//  SettingsView.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 04.03.2023.
//

import SwiftUI

struct SettingsView: View {
    @State private var presentChangePassword: Bool = false
    @State private var presentChangeEmail: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
                .frame(height: 5)
            Group {
                changeEmail
                changePassword
            }
            .padding(20)
            .foregroundColor(.black)
            .background(.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 0.3)
            )
            .padding(.horizontal, 30)
            Spacer()
            Divider().background(.secondary)
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
        .navigationTitle("Налаштування аккаунту")
    }
}

extension SettingsView {
    var changePassword: some View {
        Button {
            presentChangePassword = true
        } label: {
            HStack {
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    .resizable()
                    .frame(width: 30, height: 20)
                Text("Змінити пароль")
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .cornerRadius(10)
            }
        }
        .sheet(isPresented: $presentChangePassword) {
            ChangePasswordView()
        }
    }

    var changeEmail: some View {
        Button {
            presentChangeEmail = true
        } label: {
            HStack {
                Image(systemName: "mail")
                    .resizable()
                    .frame(width: 30, height: 20)
                Text("Змінити е-майл")
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .cornerRadius(10)
            }
        }
        .sheet(isPresented: $presentChangeEmail) {
            ChangeEmailView()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
