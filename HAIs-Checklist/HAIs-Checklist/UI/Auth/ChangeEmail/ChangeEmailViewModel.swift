//
//  ChangeEmailViewModel.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 04.03.2023.
//

import Foundation

class ChangeEmailViewModel: ObservableObject {
    private let authorizationService: AuthorizationServiceProtocol
    private let validationService: ValidationService
    
    init(env: Env = .current) {
        authorizationService = env.authorizationService
        validationService = env.validationService
    }
    
    func changeEmail(email: String) async throws {
        try validationService.validateEmail(email)
        try await authorizationService.changeEmail(email)
    }
}
