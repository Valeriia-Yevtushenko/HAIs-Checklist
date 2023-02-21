//
//  CheckPoint.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 21.02.2023.
//

import Foundation

class CheckPoint {
    var question: String
    var value: Bool
    
    init(question: String, value: Bool) {
        self.question = question
        self.value = value
    }
}

extension CheckPoint: Identifiable {}
