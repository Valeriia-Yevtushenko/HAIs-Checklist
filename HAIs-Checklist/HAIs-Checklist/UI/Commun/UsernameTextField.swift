//
//  UsernameTextField.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import SwiftUI

struct FullnameTextField: View {
    @Binding var fullname: String
    
    var body: some View {
        TextField("ФІО", text: $fullname)
            .padding()
            .background(Color(uiColor: .systemGray6))
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}
