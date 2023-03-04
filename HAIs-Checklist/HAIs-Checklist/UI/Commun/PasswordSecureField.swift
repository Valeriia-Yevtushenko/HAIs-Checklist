//
//  PasswordSecureField.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import SwiftUI

struct PasswordSecureField: View {
    @Binding var password: String
    var placeholder: String
    
    var body: some View {
        SecureField(placeholder, text: $password)
            .padding()
            .background(Color(uiColor: .systemGray6))
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}
