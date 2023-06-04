//
//  ListOfCompletedRevisionView.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 11.04.2023.
//

import SwiftUI

struct ListOfCompletedRevisionView: View {
    @StateObject var viewModel: ListOfCompletedRevisionViewModel
    
    init() {
        _viewModel = .init(wrappedValue: ListOfCompletedRevisionViewModel())
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Результати перевірок")
                .font(.largeTitle)
                .bold()
            
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
            case .processed(let revisions):
                List {
                    ForEach(revisions) { revision in
                        NavigationLink {
                            RevisionDetaliesView(revision: revision.data)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(revision.data.departament)
                                    .font(.title3)
                                    .bold()
                                HStack {
                                    Text("Дата перевірки: ")
                                        .font(.body)
                                    Text(formattedDate(revision.data.date))
                                        .font(.body)
                                }
                            }
                        }
                    }
                }
            }
            
            Divider()
                .background(.secondary)
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
        .onAppear{
            viewModel.getListOfRevision()
        }
    }
}

private extension ListOfCompletedRevisionView {
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
}

private extension ListOfCompletedRevisionView {
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: date)
    }
}

struct ListOfCompletedRevisionView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfCompletedRevisionView()
    }
}
