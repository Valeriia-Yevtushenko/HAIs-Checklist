//
//  DatabaseModel.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 21.02.2023.
//

import Foundation

protocol DatabaseModel {
    init?(from dict: [String: Any])
    var dict: [String: Any] { get }
}
