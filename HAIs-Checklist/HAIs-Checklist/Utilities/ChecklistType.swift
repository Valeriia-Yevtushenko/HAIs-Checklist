//
//  ChecklistType.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation

enum ChecklistType: String {
    case user = "USER"
    case room = "ROOM"
    case departament = "DEPARTAMENT"
}

extension ChecklistType: Codable {}
