//
//  ProfileViewModel.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    private let authorizationService: AuthorizationServiceProtocol
    @Published var error: String?
    var user: User?
    
    init(env: Environment = .current) {
        user = env.currentUser
        authorizationService = env.authorizationService
    }
    
    func logout() {
        Task {
            do {
                try await authorizationService.signOut()
                UserDefaults.standard.set(false, forKey: AppKeys.isAuthorized.rawValue)
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}
