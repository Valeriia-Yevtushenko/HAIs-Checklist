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
    let recommendations: [Recommendation]
    
    init(name: String,
         image: URL?,
         questions: [String],
         type: ChecklistType,
         recommendations: [Recommendation]) {
        self.name = name
        self.image = image
        self.questions = questions
        self.type = type
        self.recommendations = recommendations
    }
    
    required init?(from dict: [String: Any]) {
        guard let name = dict["name"] as? String,
              let image = dict["image"] as? String,
              let questions = dict["questions"] as? [String],
              let type = dict["type"] as? String,
              let recommendations = dict["recommendations"] as? [[String: Any]] else {
            return nil
        }
        
        self.name = name
        self.image = URL(string: image)
        self.questions = questions
        self.type = ChecklistType(rawValue: type) ?? .departament
        self.recommendations = recommendations.compactMap { Recommendation(from: $0) }
    }
}

extension Checklist: ObservableObject {}

struct Recommendation: Codable {
    let image: URL?
    let text: String
    let range: ClosedRange<Double>
    
    init?(from dict: [String: Any]) {
        guard let image = dict["image"] as? String,
              let text = dict["text"] as? String,
              let startAt = dict["startAt"] as? Double,
              let endAt = dict["endAt"] as? Double else {
            return nil
        }
        
        self.image = URL(string: image)
        self.text = text
        self.range = startAt...endAt
    }
}
