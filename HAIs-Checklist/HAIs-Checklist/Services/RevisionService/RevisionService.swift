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
        uncompletedChecklists = try await databaseService.get(from: "checklists")
    }
    
    func addCompletedChecklist(_ value: CompletedChecklist) {
        switch value.type{
        case .user:
            guard let checklist = value as? UserChecklist else {
                return
            }
            
            currentRevision?.userChecklists.append(checklist)
        case .room:
            guard let checklist = value as? RoomChecklist else {
                return
            }
            
            currentRevision?.roomChecklists.append(checklist)
        case .departament:
            currentRevision?.departamentChecklists.append(value)
        }
        
        guard value.type == .departament else {
            return
        }
        
        let index = uncompletedChecklists.firstIndex {
            $0.documentId == value.checklistId
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
    
    func getRevisionResult() -> RevisionResult {
        guard let checklists = currentRevision?.checklists else {
            return .none
        }
        
        var generalPercent =  checklists.reduce(0) { $0 + $1.percent }
        generalPercent /= Double(checklists.count)
        
        if generalPercent >= 30 {
            currentRevision?.result = .failure
            return .failure
        }
        
        currentRevision?.result = .success
        return .success
    }
    
    func saveRevision() async throws {
        guard let currentRevision = currentRevision else {
            return
        }
        
        currentRevision.date = .now
        try await databaseService.create(to: "revisions", document: currentRevision)
        self.currentRevision = nil
    }
}
