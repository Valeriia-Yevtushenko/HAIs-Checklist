//
//  TabViewCoordinator.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import SwiftUI

struct TabViewCoordinator: View {
    var body: some View {
        TabView {
            NavigationStack {
                GetStartedView()
            }
            .tabItem {
                Label("Checklists", systemImage: "checklist.rtl")
            }
                
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Account", systemImage: "person.crop.circle.fill")
            }
                
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .secondarySystemBackground
        }
    }
}
