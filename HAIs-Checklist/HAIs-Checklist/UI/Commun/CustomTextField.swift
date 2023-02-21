//
//  CustomTextField.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var value: String
    
    var body: some View {
        TextField(placeholder, text: $value)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}
