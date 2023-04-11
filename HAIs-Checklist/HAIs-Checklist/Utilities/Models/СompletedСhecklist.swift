//
//  File.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import Foundation
import SwiftUI

class CompletedChecklist: DatabaseModel {
    let id: String
    let name: String
    let type: ChecklistType
    var checkPoints: [CheckPoint] = []
    var recommendation: String = ""
    
    init(id: String,
         name: String,
         type: ChecklistType,
         questions: [String]) {
        self.id = id
        self.type = type
        self.name =  name
        
        questions.forEach {
            checkPoints.append(CheckPoint(question: $0, value: 1))
        }
    }
    
    required init?(from dict: [String : Any]) {
        guard let name = dict["name"] as? String,
              let id = dict["id"] as? String,
              let recommendation = dict["recommendation"] as? String,
              let type = dict["type"] as? String,
              let checkPoints = dict["checkPoints"] as? [[String: Any]] else {
            return nil
        }
        
        self.name = name
        self.id = id
        self.recommendation = recommendation
        self.type = ChecklistType(rawValue: type) ?? .departament
        self.checkPoints = checkPoints.compactMap {
            CheckPoint(from: $0)
        }
    }
}

extension CompletedChecklist {
    var percent: Double {
        let checklistSum = checkPoints.reduce(0) { $0 + $1.value }
        let percent: Double = Double(checklistSum) / Double(checkPoints.count)
        return percent
    }
}

extension CompletedChecklist: ObservableObject {}
extension CompletedChecklist: Identifiable {}

class UserChecklist: CompletedChecklist {
    var fullname: String
    var position: String
    
    init(id: String,
         name: String,
         type: ChecklistType,
         fullname: String,
         position: String,
         questions: [String]) {
        self.fullname = fullname
        self.position = position
        
        super.init(id: id,
                   name: name,
                   type: type,
                   questions: questions)
    }
    
    required init?(from dict: [String : Any]) {
        guard let fullname = dict["fullname"] as? String,
              let position = dict["position"] as? String else {
            return nil
        }
        
        self.fullname = fullname
        self.position = position
        super.init(from: dict)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        position = try container.decode(String.self, forKey: .position)
        fullname = try container.decode(String.self, forKey: .fullname)
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }
    
    enum CodingKeys: String, CodingKey {
        case fullname, position
    }
}

class RoomChecklist: CompletedChecklist {
    var room: String
    
    init(id: String,
         name: String,
         type: ChecklistType,
         room: String,
         questions: [String]) {
        self.room = room
        
        super.init(id: id,
                   name: name,
                   type: type,
                   questions: questions)
    }
    
    required init?(from dict: [String : Any]) {
        
        guard let room = dict["room"] as? String else {
            return nil
        }
        
        self.room = room
        super.init(from: dict)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        room = try container.decode(String.self, forKey: .room)
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }
    
    enum CodingKeys: String, CodingKey {
        case room
    }
}
