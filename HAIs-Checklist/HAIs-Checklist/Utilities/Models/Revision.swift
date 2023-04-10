//
//  Revision.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import Foundation

class Revision: ObservableObject {
    let departament: String
    var checklists: [CompletedChecklist] = []
    
    init(departament: String) {
        self.departament = departament
    }
}
