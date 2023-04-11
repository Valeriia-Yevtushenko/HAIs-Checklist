//
//  Revision.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import Foundation

class Revision: DatabaseModel {
    let departament: String
    var checklists: [CompletedChecklist] = []
    var result: RevisionResult  = .none
    
    init(departament: String) {
        self.departament = departament
    }
    
    required init?(from dict: [String : Any]) {
        guard let departament = dict["departament"] as? String,
              let result = dict["result"] as? String,
              let checklists = dict["checklists"] as? [[String: Any]] else {
            return nil
        }
        
        self.departament = departament
        self.checklists = checklists.compactMap { CompletedChecklist(from: $0) }
        self.result = RevisionResult(rawValue: result) ?? .none
    }
}

extension Revision: ObservableObject {}
