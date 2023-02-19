//
//  Checklist.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 18.02.2023.
//

import Foundation

class Checklist: Codable {
    let name: String
    let image: URL?
    let questions: [String]
    
    init(name: String, image: URL?, questions: [String]) {
        self.name = name
        self.image = image
        self.questions = questions
    }
    
    required init?(from dict: [String: Any]) {
        guard let name = dict["name"] as? String,
              let image = dict["image"] as? String,
              let questions = dict["questions"] as? [String] else {
            return nil
        }
        
        self.name = name
        self.image = URL(string: image)
        self.questions = questions
    }
}

extension Checklist: ObservableObject {}
