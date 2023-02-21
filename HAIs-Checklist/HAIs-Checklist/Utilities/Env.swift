//
//  Env.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation

class Env {
    let databaseService: any DatabaseServiceProtocol
    let validationService: ValidationService
    let storageService: StorageServiceProtocol
    let authorizationService: AuthorizationServiceProtocol
    let revisionService: RevisionServiceProtocol
    
    var currentUser: User? {
        storageService.get(key: AppKeys.user.rawValue)
    }
    
    init() {
        databaseService = FirestoreDatabaseService()
        revisionService = RevisionService(databaseService: databaseService)
        storageService = StorageService()
        validationService = ValidationService()
        authorizationService = FirebaseAuthorizationService(storageService: storageService)
    }
}

extension Env {
    static let current = Env()
}
