//
//  ProfileView.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import SwiftUI

struct ProfileView: View {
    private let iconWidth: CGFloat = UIScreen.main.bounds.width/1.5
    private let iconHeight: CGFloat = UIScreen.main.bounds.width/1.8
    @StateObject var viewModel: ProfileViewModel
    @State private var presentChangePassword = false
    @State private var presentChangeEmail = false
    
    init() {
        _viewModel = .init(wrappedValue: ProfileViewModel())
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 30.0) {
                Image("profile")
                    .resizable()
                    .frame(width: iconWidth, height: iconHeight)
                Text(viewModel.user?.fullname ?? "")
                    .font(.title3)
                options
                Spacer()
                    
                logout
            }
            .padding(30)
            
            Divider().background(.secondary)
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
    }
}

private extension ProfileView {
    var options: some View {
        Group {
            NavigationLink {
                
            } label: {
                HStack {
                    Image(systemName: "gear.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("Налаштування аккаунту")
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .cornerRadius(10)
                }
            }

            NavigationLink {
                
            } label: {
                Image(systemName: "list.bullet.clipboard.fill")
                    .resizable()
                    .frame(width: 25, height: 30)
                HStack {
                    Text("Результати перевірок")
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .cornerRadius(10)
                }
            }
        }
        .padding(20)
        .foregroundColor(.black)
        .background(.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 0.2)
        )
    }
    
    var logout: some View {
        Button {
            viewModel.logout()
        } label: {
            Text("Вийти")
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity)
                .frame(maxWidth: .infinity)
                .padding(10)
                .foregroundColor(.white)
                .background(.red)
                .cornerRadius(10)
        }
        .alert(viewModel.error ?? "",
               isPresented: .constant((viewModel.error != nil)),
               actions: {
            Button {
                viewModel.error = nil
            } label: {
                Text("OK")
            }
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

