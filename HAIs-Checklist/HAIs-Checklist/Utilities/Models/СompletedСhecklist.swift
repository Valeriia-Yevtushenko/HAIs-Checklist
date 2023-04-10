//
//  File.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import Foundation
import SwiftUI

class CompletedChecklist {
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
}
