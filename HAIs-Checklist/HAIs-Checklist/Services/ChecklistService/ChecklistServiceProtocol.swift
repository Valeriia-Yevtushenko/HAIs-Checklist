//
//  DatabaseService.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation

protocol ChecklistServiceProtocol {
    associatedtype ChecklistModel
    func get(by type: String) async throws -> [ChecklistModel]
}