//
//  SignUpView.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import SwiftUI

struct SignUpView: View {
    @Binding var appState: AuthFlow
    @State private var fullname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @StateObject var viewModel: SignUpViewModel
    
    init(appState: Binding<AuthFlow>) {
        _viewModel = .init(wrappedValue: SignUpViewModel())
        _appState = appState
    }
    
    var body: some View {
        VStack {
            iconImage
            FullnameTextField(fullname: $fullname)
            EmailTextField(email: $email)
            PasswordSecureField(password: $password)
            
            signUpButton
            
            Spacer()
                .frame(height: 20.0)
            
            footer
        }.padding([.trailing, .leading], 20)
    }
}

private extension SignUpView {
    var iconImage: some View {
        Image("login")
            .resizable()
            .frame(width: 200, height: 200, alignment: .center)
            .padding(.bottom, 40)
    }
    
    var signUpButton: some View {
        Button {
            viewModel.signUp(fullname: fullname,
                             email: email,
                             password: password)
        } label: {
            Text("Зареєструватися")
                .padding()
                .frame(maxWidth: .infinity)
                .font(.headline)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(15.0)
        }
        .alert("Помилка", isPresented: .constant(viewModel.error != nil)) {
            Button {
                viewModel.error = nil
            } label: {
                Text("OK")
            }
        } message: {
            Text(viewModel.error ?? "")
        }

    }
    
    var footer: some View {
        HStack {
            Text("Вже маєте аккаунт?")
                .foregroundColor(.gray)
            Button {
                appState = .signin
            } label: {
                Text("Увійти")
                    .bold()
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(appState: .constant(.signup))
    }
}
