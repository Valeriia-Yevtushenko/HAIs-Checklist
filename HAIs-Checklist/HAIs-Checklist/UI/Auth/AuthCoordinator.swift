//
//  AuthCoordinator.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import SwiftUI

enum AuthFlow {
    case signin
    case signup
}

struct AuthCoordinator: View {
    @State var currentView: AuthFlow = .signin
    
    var body: some View {
        switch currentView {
        case .signin:
            SignInView(appState: $currentView)
        case .signup:
            SignUpView(appState: $currentView)
        }
    }
}
