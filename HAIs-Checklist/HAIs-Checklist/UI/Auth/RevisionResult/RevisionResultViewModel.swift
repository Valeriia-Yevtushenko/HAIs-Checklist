//
//  RevisionResultViewModel.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 10.04.2023.
//

import Foundation

class RevisionResultViewModel: ObservableObject {
    private let revisionService: RevisionServiceProtocol
    @Published var result: RevisionResult = .none
    var currentRevision: Revision!
    
    init(env: Env = .current) {
        self.revisionService = env.revisionService
    }
    
    func getResult() {
        result = revisionService.getRevisionResult()
    }
    
    func getCurrentRevision() {
        guard let revision = revisionService.getCurrentRevision() else {
            return
        }
        
        currentRevision = revision
    }
    
    
    func saveRevisionResult() async throws {
        try await revisionService.saveRevision()
    }
}
