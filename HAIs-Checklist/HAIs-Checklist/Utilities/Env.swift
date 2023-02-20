//
//  Env.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation

class Environment {
    let checklistService: any ChecklistServiceProtocol
    
    
    init() {
        checklistService = FirestoreChecklistService()
    }
}

extension Environment {
    static let current = Environment()
}
