//
//  SignInView.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import SwiftUI

struct SignInView: View {
    @Binding var appState: AuthFlow
    @State private var email: String = ""
    @State private var password: String = ""
    @StateObject var viewModel: SignInViewModel
    
    init(appState: Binding<AuthFlow>) {
        _viewModel = .init(wrappedValue: SignInViewModel())
        _appState = appState
    }
    
    var body: some View {
        VStack {
            iconImage
            EmailTextField(email: $email)
            PasswordSecureField(password: $password)
            signInButton
            
            Spacer()
                .frame(height: 20.0)
            
            footer
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding([.trailing, .leading], 20)
    }
}

private extension SignInView {
    var signInButton: some View {
        Button {
            viewModel.signIn(email: email, password: password)
        } label: {
            Text("Увійти")
                .padding()
                .frame(maxWidth: .infinity)
                .font(.headline)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10.0)
        }
        .alert("Error", isPresented: .constant(viewModel.error != nil)) {
            Button {
                viewModel.error = nil
            } label: {
                Text("OK")
            }
        } message: {
            Text(viewModel.error ?? "")
        }
    }
    
    var iconImage: some View {
        Image("login")
            .resizable()
            .frame(width: 200, height: 200, alignment: .center)
            .padding(.bottom, 75)
    }
    
    var footer: some View {
        HStack(alignment: .bottom) {
            Text("Ще немаєте облікового запису?")
                .foregroundColor(.gray)
            
            Button {
                appState = .signup
            } label: {
                Text("Зареєструватися")
                    .bold()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(appState: .constant(.signin))
    }
}

