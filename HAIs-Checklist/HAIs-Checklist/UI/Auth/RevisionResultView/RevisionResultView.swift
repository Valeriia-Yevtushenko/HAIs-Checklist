//
//  RevisionResultView.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 10.04.2023.
//

import SwiftUI

struct RevisionResultView: View {
    private let height: CGFloat = UIScreen.main.bounds.height/1.2
    @StateObject var viewModel: RevisionResultViewModel
    
    init() {
        _viewModel = .init(wrappedValue: RevisionResultViewModel())
    }
    
    var body: some View {
        VStack  {
            switch viewModel.result {
            case.success:
                successResultView
            case .failure:
                failureResultView
            case .none:
                EmptyView()
            }
            
            Divider()
                .background(.secondary)
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.getResult()
        }
    }
}

private extension RevisionResultView {
    var successResultView: some View {
        VStack(spacing: 30.0) {
            Text("Загальний результат")
                .font(.title)
                .bold()
            image(with: "success")
            Text("Перевірка пройдена успішно")
                .font(.title2)
                .bold()
            Spacer()
            finishButton
        }
        .padding()
        .padding(.vertical, 20)
    }
    
    var failureResultView: some View {
        ScrollView {
            VStack(spacing: 30.0) {
                Text("Загальний результат")
                    .font(.largeTitle)
                    .bold()
                image(with: "failure")
                VStack(alignment: .leading, spacing: 20.0) {
                    Text("Рекомендації")
                        .font(.title3)
                        .bold()
                    Text(viewModel.result.getRecommendation())
                        .font(.body)
                }
                .frame(minWidth: 300)
                Spacer()
                finishButton
            }
            .padding(.horizontal, 20)
            .frame(minHeight: height)
        }
    }
    
    func image(with name: String) -> some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .background(.white)
            .frame(width: 250.0, height: 250.0)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 2)
            )
    }
    
    var finishButton: some View {
        Button {
            
        } label: {
            Text("Завершети перевірку")
                .padding()
                .frame(maxWidth: .infinity)
                .font(.headline)
                .foregroundColor(.white)
                .background(.red)
                .cornerRadius(10.0)
        }
    }
}

struct RevisionResultView_Previews: PreviewProvider {
    static var previews: some View {
        RevisionResultView()
    }
}
