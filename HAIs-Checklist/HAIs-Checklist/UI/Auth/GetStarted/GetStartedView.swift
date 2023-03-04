//
//  GetStartedView.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 20.02.2023.
//

import SwiftUI

struct GetStartedView: View {
    @StateObject var viewModel: GetStartedViewModel
    @State private var isPresentedDepartament: Bool = false
    @State private var isPresentedRevision: Bool = false
    @State private var isPresentedErrorAlert: Bool = false
    @State private var departament: String = ""
    private let iconWidth: CGFloat = UIScreen.main.bounds.width
    private let iconHeight: CGFloat = UIScreen.main.bounds.width
    
    init() {
        _viewModel = .init(wrappedValue: GetStartedViewModel())
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 30.0)
            
            Text("Визначення ризику ІПДМ")
                .font(.title2)
                .bold()
            Spacer()
            Image("revision")
                .resizable()
                .frame(width: iconWidth, height: iconHeight)
                .cornerRadius(10.0)
            Spacer()
            
            getStartedButton

            Divider().background(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
        .navigationDestination(isPresented: $isPresentedRevision) {
            ListOfChecklistView()
        }
    }
}

private extension GetStartedView {
    var getStartedButton: some View {
        Button {
            isPresentedDepartament = true
        } label: {
            Text("Почати перевірку")
                .padding()
                .frame(maxWidth: .infinity)
                .font(.headline)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10.0)
        }
        .padding()
        .sheet(isPresented: $isPresentedDepartament) {
            departamentInputView
                .presentationDetents([.medium])
        }
    }
    
    var departamentInputView: some View {
        VStack {
            Text("Вкажіть назву відділу")
                .font(.title3)
                .bold()
            Image("departament")
                .resizable()
                .aspectRatio(contentMode: .fit)
            TextField("Відділ", text: $departament)
                .padding()
                .background(Color(uiColor: .systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            Button {
                Task {
                    do {
                        try await viewModel.startRevision(departament: departament)
                        isPresentedDepartament = false
                        isPresentedRevision = true
                        departament = ""
                    } catch {
                        isPresentedDepartament = false
                        isPresentedErrorAlert = true
                        departament = ""
                    }
                }
            } label: {
                Text("Почати перевірку")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10.0)
            }
            .disabled(departament.isEmpty)
            .alert("Помилка",
                   isPresented: $isPresentedErrorAlert) {
                 Text("OK")
            } message: {
                Text("Перевірте інтернет зʼєднання та спробуйте ще раз.")
            }
        }
        .padding()
    }
}

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView()
    }
}
