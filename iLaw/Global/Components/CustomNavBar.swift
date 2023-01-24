//
//  CustomNavBar.swift
//  iLaw
//
//  Created by Evgeniy Safin on 17.01.2023.
//

//struct CustomNavBar_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomNavBar()
//    }
//}

import SwiftUI

struct CustomNavBar: View {
    @ObservedObject var testVM: TestManager
    init(testVM: TestManager, title: String, addButton: Bool = false) {
        self.testVM = testVM
        self.title = title
        self.addButton = addButton
    }
    
    @State private var addQuestionTrigger: Bool = false
    @State private var questionId: String = ""
    @State private var questionText: String = ""
    let title: String
    let addButton: Bool
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(title)
                    .font(.system(size: 42, weight: .black, design: .rounded))
                    .foregroundColor(Color.palette.mercury)
                Spacer()
                if addButton {
                    AddButton()
                }
            }
            // MARK: drop menu
            if addQuestionTrigger {
                // add question view
                VStack(alignment: .leading) {
                    TextField("id", text: $questionId)
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .environment(\.colorScheme, .light)
                        .padding(5)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .frame(maxWidth: 50)
                    TextEditor(text: $questionText)
                        .environment(\.colorScheme, .light)
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .overlay(alignment: .topLeading) {
                            Text(self.questionText.isEmpty ? "text" : "")
                                .font(.headline)
                                .foregroundColor(.black)
                                .opacity(0.3)
                                .padding(3)
                        }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.palette.indigo)
        .divider(.bottom)
    }
    private func AddButton() -> some View {
        Button(action: {
            if addQuestionTrigger {
                self.addQuestion()
            }
            withAnimation(.linear) {
                addQuestionTrigger.toggle()
            }
        }, label: {
            Image(systemName: "plus.message.fill")
                .font(.system(size: 24, weight: .regular, design: .rounded))
                .foregroundColor(Color.palette.mercury)
        })
    }
    private func addQuestion() {
        testVM.addQuestion(id: Int16(self.questionId)!, text: self.questionText)
    }
}

extension View {
    func divider(linewidth: CGFloat = 1.0, _ alignment: Alignment) -> some View {
        self
            .overlay(alignment: alignment) {
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [
                            .clear,
                            Color.white,
                            .clear
                        ]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .frame(height: linewidth)
            }
    }
}
