//
//  CheckPoint.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 21.02.2023.
//

import Foundation

class CheckPoint: DatabaseModel {
    var question: String
    var value: Int
    
    init(question: String, value: Int) {
        self.question = question
        self.value = value
    }
    
    required init?(from dict: [String : Any]) {
        guard let question = dict["question"] as? String,
              let value = dict["value"] as? Int else {
            return nil
        }
        
        self.question = question
        self.value = value
    }
    
    var dict: [String: Any]  {
        [
            "question": question,
            "value": value
        ]
    }
}

extension CheckPoint: Identifiable {}
