//
//  Checklist.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 18.02.2023.
//

import Foundation

class Checklist: DatabaseModel {
    let name: String
    let image: URL?
    let questions: [String]
    let type: ChecklistType
    
    init(name: String, image: URL?, questions: [String], type: ChecklistType) {
        self.name = name
        self.image = image
        self.questions = questions
        self.type = type
    }
    
    required init?(from dict: [String: Any]) {
        guard let name = dict["name"] as? String,
              let image = dict["image"] as? String,
              let questions = dict["questions"] as? [String],
              let type = dict["type"] as? String else {
            return nil
        }
        
        self.name = name
        self.image = URL(string: image)
        self.questions = questions
        self.type = ChecklistType(rawValue: type) ?? .departament
    }
}

extension Checklist: ObservableObject {}
