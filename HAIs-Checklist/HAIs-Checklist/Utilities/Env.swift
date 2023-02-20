//
//  Env.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation

class Environment {
    let checklistService: any ChecklistServiceProtocol
    let validationService: ValidationService
    let storageService: StorageServiceProtocol
    let authorizationService: AuthorizationServiceProtocol
    var currentUser: User? {
        storageService.get(key: AppKeys.user.rawValue)
    }
    
    init() {
        checklistService = FirestoreChecklistService()
        storageService = StorageService()
        validationService = ValidationService()
        authorizationService = FirebaseAuthorizationService(storageService: storageService)
    }
}

extension Environment {
    static let current = Environment()
}
