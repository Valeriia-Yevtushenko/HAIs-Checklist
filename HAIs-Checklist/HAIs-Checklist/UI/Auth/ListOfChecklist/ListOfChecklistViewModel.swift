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
    
    init(env: Env = .current) {
        self.revisionService = env.revisionService
    }
    
    func getChecklists() {
        let checklists = revisionService.getUncompletedChecklists()
        self.processable = .processed(checklists)
    }
    
    func revisionStatus() {
        var currentRevision = revisionService.getCurrentRevision()
        currentRevision?.checklists
    }
}
