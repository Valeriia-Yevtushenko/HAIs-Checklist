//
//  ValidationService.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import Foundation

class ValidationService {
    func validateEmail(_ email: String?) throws {
        guard let email = email else {
            throw ValidationError.emptyValue
        }
        
        let emailPattern = #"^\S+@\S+\.\S+$"#
        
        guard email.range(
            of: emailPattern,
            options: .regularExpression) != nil else {
            throw ValidationError.invalidValue
        }
    }
    
    func validatePassword(_ password: String?) throws {
        guard let password = password else {
            throw ValidationError.emptyValue
        }
        
        guard password.count > 8 else {
            throw ValidationError.passwordTooShort
        }
        
        guard password.count < 20 else {
            throw ValidationError.passwordTooLong
        }
    }
}

extension ValidationService {
    enum ValidationError: LocalizedError {
        case invalidValue
        case emptyValue
        case passwordTooShort
        case passwordTooLong
        
        var errorDescription: String? {
            switch self {
            case .invalidValue:
                return "Електронна адреса недійсна"
            case .passwordTooShort:
                return "Пароль занадто короткий"
            case .passwordTooLong:
                return "Пароль занадто довгий"
            case .emptyValue:
                return "Поле не повинно бути пустим"
            }
        }
    }
}
