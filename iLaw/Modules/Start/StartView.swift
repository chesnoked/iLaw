//
//  StartView.swift
//  iLaw
//
//  Created by Evgeniy Safin on 03.01.2023.
//

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

import SwiftUI

struct StartView: View {
    @StateObject private var testVM: TestManager = TestManager()
    @State private var showDropMenu: Bool = false
    @State private var id: String = ""
    @State private var text: String = ""
    @State private var amount: Int = 4
    @State private var isValid: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            NavBar()
            ZStack {
                if showDropMenu {
                    DropMenu()
                        .padding()
                } else {
                    Questions()
                }
            }
        }
    }
}

extension StartView {
    private func NavBar() -> some View {
        VStack(spacing: 0) {
            HStack {
                Text("Start")
                    .font(.system(size: 42, weight: .black, design: .rounded))
                    .foregroundColor(Color.palette.mercury)
                Spacer()
                AddButton()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.palette.indigo)
        .divider(.bottom)
    }
}

extension StartView {
    private func AddButton() -> some View {
        Button(action: {
            if showDropMenu { addQuestion() }
            withAnimation(.linear(duration: 0.13)) {
                showDropMenu.toggle()
            }
        }, label: {
            Image(systemName: "plus.message.fill")
                .font(.system(size: 24, weight: .regular, design: .rounded))
                .foregroundColor(Color.palette.mercury)
        })
    }
    private func addQuestion() {
        guard let id = Int16(id),
              !text.isEmpty
        else {
            self.id = ""
            self.text = ""
            return
        }
        testVM.addQuestion(id, text)
    }
    private func DropMenu() -> some View {
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
                    Picker(selection: $amount) {
                        ForEach(1...10, id: \.self) { index in
                            Text("\(index)")
                                .tag(index)
                        }
                    } label: {
                        Text("\(amount)")
                    }
                }
                ForEach(1...amount, id: \.self) { index in
                    // MARK: answers
                    HStack {
                        TextEditor(text: $text)
                            .environment(\.colorScheme, .light)
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .overlay(alignment: .topLeading) {
                                Text(self.text.isEmpty ? "answer \(index)" : "")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .opacity(0.3)
                                    .padding(3)
                            }
                        Toggle("", isOn: $isValid)
                            .labelsHidden()
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
    
}

extension StartView {
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

extension StartView {
    private func Questions() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                ForEach(testVM.questions) { question in
                    QuestionItem(question: question)
                }
            }
            .padding()
        }
    }
}
