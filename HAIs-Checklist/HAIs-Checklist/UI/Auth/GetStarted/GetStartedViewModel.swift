//
//  GetStartedViewModel.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 21.02.2023.
//

import Foundation

class GetStartedViewModel: ObservableObject {
    private let revisionService: RevisionServiceProtocol
    
    init(env: Env = .current) {
        self.revisionService = env.revisionService
    }
    
    func startRevision(departament: String) async throws {
        try await revisionService.startRevision(departament: departament)
    }
}
