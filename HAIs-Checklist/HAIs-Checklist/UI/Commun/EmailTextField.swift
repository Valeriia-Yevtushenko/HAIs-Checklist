//
//  EmailTextField.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import Foundation

import SwiftUI

struct EmailTextField: View {
    @Binding var email: String
    
    var body: some View {
        TextField("E-мейл", text: $email)
            .padding()
            .background(Color(uiColor: .systemGray6))
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}
