//
//  RevisionService.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 21.02.2023.
//

import Foundation

class RevisionService: RevisionServiceProtocol {
    private let databaseService: any DatabaseServiceProtocol
    private var uncompletedChecklists: [Document<Checklist>] = []
    private var currentRevision: Revision?
    
    init(databaseService: any DatabaseServiceProtocol) {
        self.databaseService = databaseService
    }
    
    func startRevision(departament: String) async throws {
        currentRevision = Revision(departament: departament)
        uncompletedChecklists = try await databaseService.get()
    }
    
    func addCompletedChecklist(_ checklist: СompletedСhecklist) {
        currentRevision?.checklists.append(checklist)
        
        guard checklist.type == .departament else {
            return
        }
        
        let index = uncompletedChecklists.firstIndex {
            $0.documentId == checklist.id
        }
        
        guard let index = index else {
            return
        }
        
        uncompletedChecklists.remove(at: index)
    }
    
    func getUncompletedChecklists() -> [Document<Checklist>] {
        return uncompletedChecklists
    }
    
    func getCurrentRevision() -> Revision? {
        return currentRevision
    }
}
