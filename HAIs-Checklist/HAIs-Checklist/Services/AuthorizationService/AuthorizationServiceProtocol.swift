//
//  AuthorizationServiceProtocol.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation

protocol AuthorizationServiceProtocol: AnyObject {
    func createUser(username: String,
                    email: String,
                    password: String) async throws
    func signIn(email: String,
                password: String) async throws
    func changePassword(_ password: String) async throws
    func changeEmail(_ email: String) async throws
    func signOut() async throws
}
