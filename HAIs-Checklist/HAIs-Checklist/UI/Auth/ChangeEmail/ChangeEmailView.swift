//
//  ChangeEmailView.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 04.03.2023.
//

import SwiftUI

import SwiftUI

struct ChangeEmailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @StateObject var viewModel: ChangeEmailViewModel
    @State private var error: String?
    
    init() {
        _viewModel = .init(wrappedValue: ChangeEmailViewModel())
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Change Email")
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
            EmailTextField(email: $email)
            changeButton
        }
        .padding(20)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity, alignment: .top)
        .foregroundColor(.black)
    }
}

private extension ChangeEmailView {
    var changeButton: some View {
        Button {
            dismiss()
            Task {
                do {
                    try await viewModel.changeEmail(email: email)
                    
                } catch {
                    self.error = error.localizedDescription
                }
            }
        } label: {
            Text("Change")
                .frame(maxWidth: .infinity)
                .padding(10)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
        }
    }
}

struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmailView()
    }
}
