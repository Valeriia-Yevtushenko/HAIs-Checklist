//
//  ListOfChecklistViewModel.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation

@MainActor
class ListOfChecklistViewModel: ObservableObject {
    private let checklistService: any ChecklistServiceProtocol
    @Published var processable: Processable<[Document<Checklist>]> = .processing
    
    init(env: Environment = .current) {
        checklistService = env.checklistService
    }
    
    func getChecklists() {
        Task {
            do {
                let checklists = try await checklistService.get(by: "") as? [Document<Checklist>] ?? []
                self.processable = .processed(checklists)
            } catch {
                self.processable = .failure("Oops, somthing went wrong...")
            }
        }
    }
}
