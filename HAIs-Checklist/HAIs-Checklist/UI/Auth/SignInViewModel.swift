//
//  SignInViewModel.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import Foundation

@MainActor
class SignInViewModel: ObservableObject {
    private let authorizationService: AuthorizationServiceProtocol
    @Published var error: String?
    
    init(env: Env = .current) {
        authorizationService = env.authorizationService
    }
    
    func signIn(email: String, password: String) {
        Task {
            do {
                try await authorizationService.signIn(email: email, password: password)
                UserDefaults.standard.set(true, forKey: AppKeys.isAuthorized.rawValue)
            } catch {
                
                self.error = error.localizedDescription
            }
        }
    }
}
