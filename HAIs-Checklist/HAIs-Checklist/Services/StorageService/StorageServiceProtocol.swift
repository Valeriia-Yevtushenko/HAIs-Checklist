//
//  StorageServiceProtocol.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation

protocol StorageServiceProtocol: AnyObject {
    func set<T: Codable>(_ data: T, key: String)
    func remove(key: String)
    func get<T: Codable>(key: String) -> T?
}
