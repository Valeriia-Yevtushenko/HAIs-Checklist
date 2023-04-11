//
//  ListOfCompletedRevisionViewModel.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 11.04.2023.
//

import Foundation

class ListOfCompletedRevisionViewModel: ObservableObject {
    private let databaseService: DatabaseServiceProtocol
    @Published var processable: Processable<[Document<Revision>]> = .processing
    
    init(env: Env = .current) {
        self.databaseService = env.databaseService
    }
    
    @MainActor
    func getListOfRevision() {
        Task {
            do {
                let list: [Document<Revision>] = try await databaseService.get(from: "revisions")
                
                processable = list.isEmpty ? .processedNoValue: .processed(list)
            } catch {
                processable = .failure(error.localizedDescription)
            }
        }
    }
}
