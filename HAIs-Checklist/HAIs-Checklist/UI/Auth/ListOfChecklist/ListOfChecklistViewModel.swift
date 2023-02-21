//
//  ListOfChecklistViewModel.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation

@MainActor
class ListOfChecklistViewModel: ObservableObject {
    private let revisionService: RevisionServiceProtocol
    @Published var processable: Processable<[Document<Checklist>]> = .processing
    @Published var isNecessaryChecklistsFilled: Bool = false
    
    init(env: Env = .current) {
        self.revisionService = env.revisionService
    }
    
    func checkIfNecessaryChecklistsFilled() {
        let currentRevision = revisionService.getCurrentRevision()
        let departamentsChecklist = currentRevision?.checklists.filter { $0.type == .departament } ?? []
        let userChecklist = currentRevision?.checklists.filter { $0.type == .user } ?? []
        let roomChecklist = currentRevision?.checklists.filter { $0.type == .room } ?? []
        
        guard departamentsChecklist.count == 2,
              userChecklist.count >= 2,
              roomChecklist.count >= 1 else {
            isNecessaryChecklistsFilled = false
            return
        }
        
        isNecessaryChecklistsFilled = true
    }
    
    func getChecklists() {
        let checklists = revisionService.getUncompletedChecklists()
        self.processable = .processed(checklists)
    }
}
