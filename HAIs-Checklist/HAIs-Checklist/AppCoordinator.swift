//
//  AppCoordinator.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import SwiftUI

struct AppCoordinator: View {
    @AppStorage(AppKeys.isAuthorized.rawValue) var isAuthorized: Bool = UserDefaults.standard.bool(forKey: AppKeys.isAuthorized.rawValue)
    
    var body: some View {
        if isAuthorized {
            TabViewCoordinator()
        } else {
            AuthCoordinator()
        }
    }
}
