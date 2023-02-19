//
//  Processable.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation

enum Processable<Value> {
    case processing
    case processedNoValue
    case processed(Value)
    case failure(String)
}
