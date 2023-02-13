//
//  DropMenu.swift
//  iLaw
//
//  Created by Evgeniy Safin on 11.02.2023.
//

struct DropMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropMenu(id: .constant("108"), text: .constant("question 108"))
    }
}

import SwiftUI

struct DropMenu: View {
    @EnvironmentObject private var testVM: TestManager
    @Binding var id: String
    @Binding var text: String
//    @State private var amount: Int = 4
    @State private var isValid: Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("Question")
                    .font(.headline)
                    .foregroundColor(Color.palette.mercury)
                QuestionId()
                QuestionText()
                HStack {
                    Text("Answers")
                        .font(.headline)
                        .foregroundColor(Color.palette.mercury)
                    Spacer()
                    Picker(selection: $testVM.amount) {
                        ForEach(1...10, id: \.self) { index in
                            Text("\(index)")
                                .tag(index)
                        }
                    } label: {
                        Text("\(self.testVM.amount)")
                    }
                }
                ForEach(0..<self.testVM.amount, id: \.self) { index in
                    // MARK: answers
                    HStack(alignment: .bottom) {
                        if let bindingAnswer = self.getBinding(index) {
                            TextEditor(text: bindingAnswer.text)
                                .environment(\.colorScheme, .light)
                                .frame(height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                                .overlay(alignment: .topLeading) {
//                                    Text("123")
                                    Text(self.textIsEmpty(index) ? "answer \(index + 1)" : "")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .opacity(0.3)
                                        .padding(EdgeInsets(top: 6, leading: 3, bottom: 3, trailing: 3))
                                }
                            Toggle("", isOn: bindingAnswer.isValid)
                                .labelsHidden()
                                .padding(.horizontal)
                        }
                        
//                        TextEditor(text: $text)
                        
                    }
                }
            }
        }
        .onChange(of: self.testVM.amount) { newValue in
            print(newValue)
        }
    }
    private func getBinding(_ index: Int) -> Binding<AnswerModel>? {
        return self.$testVM.answers[index]
    }
    private func textIsEmpty(_ index: Int) -> Bool {
        return self.testVM.answers[index].text.isEmpty
    }
}

extension DropMenu {
    private func QuestionId() -> some View {
        TextField("id", text: $id)
            .font(.headline)
            .foregroundColor(Color.black)
            .environment(\.colorScheme, .light)
            .padding(5)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            .frame(maxWidth: 50)
    }
    private func QuestionText() -> some View {
        TextEditor(text: $text)
            .environment(\.colorScheme, .light)
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            .overlay(alignment: .topLeading) {
                Text(self.text.isEmpty ? "text" : "")
                    .font(.headline)
                    .foregroundColor(.black)
                    .opacity(0.3)
                    .padding(3)
            }
    }
}
