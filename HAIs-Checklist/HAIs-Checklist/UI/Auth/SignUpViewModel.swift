//
//  SignUpViewModel.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import Foundation

@MainActor
class SignUpViewModel: ObservableObject {
    private let validationService: ValidationService
    private let authorizationService: AuthorizationServiceProtocol
    @Published var error: String?
    
    init(env: Environment = .current) {
        self.validationService = env.validationService
        self.authorizationService = env.authorizationService
    }
    
    func signUp(fullname: String, email: String, password: String) {
        Task {
            do {
                try validationService.validateEmail(email)
                try validationService.validatePassword(password)
                try await authorizationService.createUser(fullname: fullname,
                                                          email: email,
                                                          password: password)
                UserDefaults.standard.set(true, forKey: AppKeys.isAuthorized.rawValue)
            } catch let validationError {
                self.error = validationError.localizedDescription
            }
        }
    }
}
