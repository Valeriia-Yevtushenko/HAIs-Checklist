//
//  User.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation

struct User: Codable {
    let uid: String
    var email: String
    var fullname: String
    var password: String
}
