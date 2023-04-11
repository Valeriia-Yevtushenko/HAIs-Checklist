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
    let checklistId: String
    let name: String
    let type: ChecklistType
    var checkPoints: [CheckPoint] = []
    var recommendation: String = ""
    
    init(checklistId: String,
         name: String,
         type: ChecklistType,
         questions: [String]) {
        self.id = UUID().uuidString
        self.checklistId = checklistId
        self.type = type
        self.name =  name
        
        questions.forEach {
            checkPoints.append(CheckPoint(question: $0, value: 1))
        }
    }
    
    required init?(from dict: [String : Any]) {
        guard let name = dict["name"] as? String,
              let checklistId = dict["checklistId"] as? String,
              let id = dict["id"] as? String,
              let recommendation = dict["recommendation"] as? String,
              let type = dict["type"] as? String,
              let checkPoints = dict["checkPoints"] as? [[String: Any]] else {
            return nil
        }
        
        self.name = name
        self.id = id
        self.checklistId = checklistId
        self.recommendation = recommendation
        self.type = ChecklistType(rawValue: type) ?? .departament
        self.checkPoints = checkPoints.compactMap {
            CheckPoint(from: $0)
        }
    }
    
    var dict: [String : Any] {
        [
            "name": name,
            "id": id,
            "checklistId": checklistId,
            "type": type.rawValue,
            "recommendation": recommendation,
            "checkPoints": checkPoints.map { $0.dict }
        ]
    }
}

extension CompletedChecklist {
    var percent: Double {
        let checklistSum = checkPoints.reduce(0) { $0 + $1.value }
        let maxPossibleValue = 25 * checkPoints.count
        var percent: Double = Double(checklistSum) / Double(maxPossibleValue)
        percent *= 100
        return percent
    }
}

extension CompletedChecklist: ObservableObject {}
extension CompletedChecklist: Identifiable {}

class UserChecklist: CompletedChecklist {
    var fullname: String
    var position: String
    
    init(checklistId: String,
         name: String,
         type: ChecklistType,
         fullname: String,
         position: String,
         questions: [String]) {
        self.fullname = fullname
        self.position = position
        
        super.init(checklistId: checklistId,
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
    
    override var dict: [String : Any] {
        [
            "name": name,
            "id": id,
            "fullname": fullname,
            "position": position,
            "checklistId": checklistId,
            "type": type.rawValue,
            "recommendation": recommendation,
            "checkPoints": checkPoints.map { $0.dict }
        ]
    }
}

class RoomChecklist: CompletedChecklist {
    var room: String
    
    init(checklistId: String,
         name: String,
         type: ChecklistType,
         room: String,
         questions: [String]) {
        self.room = room
        
        super.init(checklistId: checklistId,
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
    
    override var dict: [String : Any] {
        [
            "name": name,
            "id": id,
            "room": room,
            "checklistId": checklistId,
            "type": type.rawValue,
            "recommendation": recommendation,
            "checkPoints": checkPoints.map { $0.dict }
        ]
    }
}
