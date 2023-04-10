//
//  CheckPoint.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 21.02.2023.
//

import Foundation

class CheckPoint {
    var question: String
    var value: Int
    
    init(question: String, value: Int) {
        self.question = question
        self.value = value
    }
}

extension CheckPoint: Identifiable {}
