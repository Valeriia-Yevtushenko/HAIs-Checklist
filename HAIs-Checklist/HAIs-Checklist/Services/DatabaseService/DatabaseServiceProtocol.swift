//
//  DatabaseService.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation

protocol DatabaseServiceProtocol: AnyObject {
    func get<T: DatabaseModel>(from collection: String) async throws -> [Document<T>]
}
