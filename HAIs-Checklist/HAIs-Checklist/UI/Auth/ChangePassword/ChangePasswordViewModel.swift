//
//  ChangePasswordViewModel.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 04.03.2023.
//

import Foundation

class ChangePasswordViewModel: ObservableObject {
    private let authorizationService: AuthorizationServiceProtocol
    private let validationService: ValidationService
    private var user: User?
    
    init(env: Env = .current) {
        user = env.currentUser
        authorizationService = env.authorizationService
        validationService = env.validationService
    }
    
    func changePassword(oldPassword: String,
                        newPassword: String,
                        confirmeNewPassword: String) async throws {
        if oldPassword != user?.password {
            throw ChangePasswordError.wrongOldPassword
        } else if newPassword != confirmeNewPassword {
            throw ChangePasswordError.newPasswordDidNotMatch
        }
        
        try validationService.validatePassword(newPassword)
        try await authorizationService.changePassword(newPassword)
    }
}
