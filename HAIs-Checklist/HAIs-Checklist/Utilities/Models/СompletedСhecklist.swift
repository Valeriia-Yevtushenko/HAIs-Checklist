//
//  File.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import Foundation
import SwiftUI

class СompletedСhecklist {
    let id: String
    let name: String
    let type: ChecklistType
    var checkPoints: [CheckPoint] = []
    
    init(id: String,
         name: String,
         type: ChecklistType,
         questions: [String]) {
        self.id = id
        self.type = type
        self.name =  name
        
        questions.forEach {
            checkPoints.append(CheckPoint(question: $0, value: true))
        }
    }
}

extension СompletedСhecklist: ObservableObject {}
extension СompletedСhecklist: Identifiable {}

class UserChecklist: СompletedСhecklist {
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

class RoomChecklist: СompletedСhecklist {
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
