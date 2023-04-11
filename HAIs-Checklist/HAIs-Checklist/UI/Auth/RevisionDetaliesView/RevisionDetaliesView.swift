//
//  RevisionDetaliesView.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 11.04.2023.
//

import SwiftUI

struct RevisionDetaliesView: View {
    private let width: CGFloat = UIScreen.main.bounds.width / 1.15
    private let revision: Revision
    
    init(revision: Revision) {
        self.revision = revision
    }
    
    var body: some View {
        VStack {

            HStack(alignment: .center) {
                Text(revision.departament)
                    .bold()
                    .font(.largeTitle)
                switch revision.result {
                case .success:
                    image(with: "success")
                default:
                    image(with: "failure")
                }
            }
            
            ScrollView {
                ForEach(revision.checklists) { checklist in
                    VStack(alignment: .leading, spacing: 2) {
                        Spacer().frame(width: width, height: 10)
                        switch checklist.type {
                        case .departament:
                            generalInfoView(checklist: checklist)
                        case .room:
                            roomInfoView(checklist: checklist as? RoomChecklist)
                        case .user:
                            userInfoView(checklist: checklist as? UserChecklist)
                        }
                        Spacer().frame(width: width, height: 10)
                    }
                    .background(.white)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, lineWidth: 2)
                    )
                    .frame(width: width)
                    .padding(.vertical, 5)
                }
            }
            
            Divider()
                .background(.secondary)
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
    }
}

private extension RevisionDetaliesView {
    @ViewBuilder
    func userInfoView(checklist: UserChecklist?) -> some View {
        if let checklist = checklist{
            Group{
                Text(checklist.name)
                    .font(.title3)
                    .bold()
                HStack {
                    Text("ФІО: ")
                        .font(.title3.weight(.medium))
                    Text(checklist.fullname)
                        .font(.body)
                }
                HStack {
                    Text("Посада: ")
                        .font(.body.weight(.medium))
                    Text(checklist.position)
                        .font(.body)
                }
                Text(checklist.recommendation)
                    .font(.body)
            }
            .padding(.horizontal, 10)
        } else {
            EmptyView()
        }
    }
    
    func generalInfoView(checklist: CompletedChecklist) ->  some View {
        Group {
            Text(checklist.name)
                .font(.title3)
                .bold()
            Text(checklist.recommendation)
                .font(.body)
        }
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    func roomInfoView(checklist: RoomChecklist?) ->  some View {
        if let checklist = checklist{
            Group {
                Text(checklist.name)
                    .font(.title3)
                    .bold()
                HStack(alignment: .bottom) {
                    Text("Місце розташування  робочого місця: ")
                        .font(.body.weight(.medium))
                    Text(checklist.room)
                        .font(.body)
                }
                
                Text(checklist.recommendation)
                    .font(.body)
            }
            .padding(.horizontal, 10)
        } else {
            EmptyView()
        }
    }
    
    func image(with name: String) -> some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
    }
}

