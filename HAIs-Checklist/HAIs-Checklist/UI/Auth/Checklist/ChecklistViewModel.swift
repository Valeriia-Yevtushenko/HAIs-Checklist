//
//  ChecklistViewModel.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import Foundation

class ChecklistViewModel: ObservableObject {
    private let revisionService: RevisionServiceProtocol
    var checklist: Document<Checklist>
    @Published var completedСhecklist: СompletedСhecklist!
    
    init(env: Env = .current, checklist: Document<Checklist>) {
        self.checklist = checklist
        self.revisionService = env.revisionService
        
        if checklist.data.type == .departament {
            completedСhecklist = СompletedСhecklist(id: checklist.documentId,
                                                    type: checklist.data.type,
                                                    questions: checklist.data.questions)
        }
    }
    
    func addCompletedChecklist() {
        revisionService.addCompletedChecklist(completedСhecklist)
    }
}
