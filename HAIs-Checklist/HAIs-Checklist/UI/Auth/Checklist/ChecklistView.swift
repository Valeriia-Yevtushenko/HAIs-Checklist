//
//  ChecklistView.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import SwiftUI

struct ChecklistView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ChecklistViewModel
    @State private var isFilledGeneraInform: Bool = false
    @State private var position: String = ""
    @State private var room: String = ""
    @State private var fullname: String = ""
    
    init(checklist: Document<Checklist>) {
        _viewModel = .init(wrappedValue: ChecklistViewModel(checklist: checklist))
    }
    
    var body: some View {
        VStack {
            if isFilledGeneraInform {
                questions
                    .transition(.slide)
            } else {
                switch viewModel.checklist.data.type {
                case .room:
                    roomGeneralInfo
                case .user:
                    userGeneralInfo
                case .departament:
                    questions
                }
            }
            
            Divider().background(.secondary)
        }
        .navigationTitle(isFilledGeneraInform ? viewModel.checklist.data.name : "")
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
    }
}

private extension ChecklistView {
    var userGeneralInfo: some View {
        VStack {
            Text(viewModel.checklist.data.name)
                .bold()
                .font(.title)
                .multilineTextAlignment(.center)
            Image("staff")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            CustomTextField(placeholder: "ФІО", value:  $fullname)
            CustomTextField(placeholder: "Посада", value:  $position)
            Spacer()
            Button {
                let checklist = viewModel.checklist
                viewModel.completedСhecklist = UserChecklist(id: checklist.documentId,
                                                             type: checklist.data.type,
                                                             fullname: fullname,
                                                             position: position,
                                                             questions: checklist.data.questions)
                withAnimation {
                    isFilledGeneraInform = true
                }
            } label: {
                Text("Далі")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10.0)
            }.disabled((fullname.isEmpty || position.isEmpty))
        }.padding(20)
    }
    
    var roomGeneralInfo: some View {
        VStack {
            Text(viewModel.checklist.data.name)
                .bold()
                .font(.title)
                .multilineTextAlignment(.center)
            Image("workplace")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            CustomTextField(placeholder: "Робоче місце", value:  $room)
            Spacer()
            Button {
                let checklist = viewModel.checklist
                viewModel.completedСhecklist = RoomChecklist(id: checklist.documentId,
                                                             type: checklist.data.type,
                                                             room: room,
                                                             questions: checklist.data.questions)
                withAnimation {
                    isFilledGeneraInform = true
                }
            } label: {
                Text("Далі")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10.0)
            }.disabled(room.isEmpty)
        }.padding(20)
    }
    
    var questions: some View {
        ScrollView {
            ForEach($viewModel.completedСhecklist.answers) { answer in
                HStack(alignment: .center) {
                    Text(answer.question.wrappedValue)
                    Spacer()
                    Picker("", selection: answer.value) {
                        Text("Так").tag(true)
                        Text("Ні").tag(false)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 120)
                }
                .padding(20)
                .background(.blue.opacity(0.08))
                .cornerRadius(10)
            }
            
            Button {
                viewModel.addCompletedChecklist()                
                dismiss()
            } label: {
                Text("Зберегти")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10.0)
            }
            
        }.padding(20)
    }
}

