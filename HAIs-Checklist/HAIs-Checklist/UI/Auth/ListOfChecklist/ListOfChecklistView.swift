//
//  ListOfChecklistView.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListOfChecklistView: View {
    @StateObject var viewModel: ListOfChecklistViewModel
    private let cellWidth: CGFloat = UIScreen.main.bounds.width/2.3
    private let columns = [
        GridItem(),
        GridItem()
    ]
    
    init() {
        _viewModel = .init(wrappedValue: ListOfChecklistViewModel())
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            Text("Оберіть чекліст")
                .bold()
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            switch viewModel.processable {
            case .failure(let error):
                VStack {
                    Spacer()
                    Image("smth-went-wrong")
                        .resizable()
                        .frame(width: 300, height: 300)
                    Text(error)
                    Spacer()
                }
            case .processedNoValue:
                emptyMessageView
            case .processing:
                loadingView
            case .processed(let values):
                VStack {
                    checklists(values)
                    
                    if viewModel.isNecessaryChecklistsFilled {
                        finishRevisionButton
                    }
                }
                .padding(20)
            }
            Divider()
                .background(.secondary)
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.getChecklists()
            viewModel.checkIfNecessaryChecklistsFilled()
        }
    }
}

private extension ListOfChecklistView {
    func checklists(_ checklists: [Document<Checklist>]) -> some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(checklists) { checklist in
                    NavigationLink {
                        ChecklistView(checklist: checklist)
                    } label: {
                        HStack {
                            Text(checklist.data.name)
                                .font(.headline)
                                .fontWeight(.medium)
                                .italic()
                        }
                        .padding()
                        .frame(width: cellWidth, height: cellWidth)
                        .background(
                            WebImage(url: checklist.data.image)
                                .resizable()
                                .indicator(.activity)
                                .aspectRatio(contentMode: .fit)
                                .opacity(0.3)
                        )
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.blue, lineWidth: 0.5)
                        )
                    }
                }
            }
        }
    }
    
    var emptyMessageView: some View {
        VStack {
            Spacer()
            Text("No Checklists")
            Spacer()
        }
    }
    
    var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
                .frame(width: 25, height: 25)
                .background(Rectangle()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 10))
            Spacer()
        }
    }
    
    var finishRevisionButton: some View {
        NavigationLink {
            RevisionResultView()
        } label: {
            Text("Завершети перевірку")
                .padding()
                .frame(maxWidth: .infinity)
                .font(.headline)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10.0)
        }
    }
}


