//
//  Revision.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import Foundation

class Revision: DatabaseModel {
    let departament: String
    var departamentChecklists: [CompletedChecklist] = []
    var userChecklists: [UserChecklist] = []
    var roomChecklists: [RoomChecklist] = []
    var result: RevisionResult  = .none
    var date: Date = .now
    
    var checklists: [CompletedChecklist] {
        userChecklists + roomChecklists + departamentChecklists
    }
    
    init(departament: String) {
        self.departament = departament
    }
    
    required init?(from dict: [String : Any]) {
        guard let departament = dict["departament"] as? String,
              let result = dict["result"] as? String,
              let date = dict["date"] as? Date,
              let roomChecklists = dict["roomChecklists"] as? [[String: Any]],
              let userChecklists = dict["userChecklists"] as? [[String: Any]],
              let departamentChecklists = dict["departamentChecklists"] as? [[String: Any]]  else {
            return nil
        }
        
        self.departament = departament
        self.departamentChecklists = departamentChecklists.compactMap { CompletedChecklist(from: $0) }
        self.userChecklists = userChecklists.compactMap { UserChecklist(from: $0) }
        self.roomChecklists = roomChecklists.compactMap { RoomChecklist(from: $0) }
        self.result = RevisionResult(rawValue: result) ?? .none
        self.date = date
    }
    
    var dict: [String : Any] {
        [
            "departament": departament,
            "result": result.rawValue,
            "date": date,
            "departamentChecklists": departamentChecklists.map { $0.dict },
            "userChecklists": userChecklists.map { $0.dict },
            "roomChecklists": roomChecklists.map { $0.dict }
        ]
    }
}

extension Revision: ObservableObject {}
