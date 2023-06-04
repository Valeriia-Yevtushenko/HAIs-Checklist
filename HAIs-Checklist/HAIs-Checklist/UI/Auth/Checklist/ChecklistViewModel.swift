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
    @Published var completedСhecklist: CompletedChecklist!
    
    init(env: Env = .current, checklist: Document<Checklist>) {
        self.checklist = checklist
        self.revisionService = env.revisionService
        
        if checklist.data.type == .departament {
            completedСhecklist = CompletedChecklist(checklistId: checklist.documentId,
                                                    name: checklist.data.name,
                                                    type: checklist.data.type,
                                                    questions: checklist.data.questions)
        }
    }
    
    func addCompletedChecklist() {
        let percent = completedСhecklist.percent
        let recommendation: String = checklist.data.recommendations.first {
            $0.range.contains(percent)
        }?.text ?? ""
        completedСhecklist.recommendation = recommendation
        revisionService.addCompletedChecklist(completedСhecklist)
    }
}
