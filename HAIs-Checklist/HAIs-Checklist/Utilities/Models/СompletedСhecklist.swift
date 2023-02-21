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
    let type: ChecklistType
    var answers: [Answer] = []
    
    init(id: String, type: ChecklistType, questions: [String]) {
        self.id = id
        self.type = type
        
        questions.forEach {
            answers.append(Answer(question: $0, value: true))
        }
    }
}

extension СompletedСhecklist: ObservableObject {}
extension СompletedСhecklist: Identifiable {}

class UserChecklist: СompletedСhecklist {
    var fullname: String
    var position: String
    
    init(id: String,
         type: ChecklistType,
         fullname: String,
         position: String,
         questions: [String]) {
        self.fullname = fullname
        self.position = position
        
        super.init(id: id, type: type, questions: questions)
    }
}

class RoomChecklist: СompletedСhecklist {
    var room: String
    
    init(id: String,
         type: ChecklistType,
         room: String,
         questions: [String]) {
        self.room = room
        
        super.init(id: id, type: type, questions: questions)
    }
}

class Answer {
    var question: String
    var value: Bool
    
    init(question: String, value: Bool) {
        self.question = question
        self.value = value
    }
}

extension Answer: Identifiable {}
