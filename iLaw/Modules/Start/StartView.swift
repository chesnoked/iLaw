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
    @EnvironmentObject private var testVM: TestManager
    @State private var showDropMenu: Bool = false
    @State private var id: String = ""
    @State private var text: String = ""
    var body: some View {
        VStack(spacing: 0) {
            NavBar()
            ZStack {
                if showDropMenu {
                    DropMenu(id: $id, text: $text)
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
              !text.isEmpty,
              answersTextIsEmpty()
        else {
            self.id = ""
            self.text = ""
            return
        }
        testVM.addQuestion(id, text, self.testVM.answers)
    }
    private func answersTextIsEmpty() -> Bool {
        guard !self.testVM.answers.isEmpty else { return false }
        var bool = true
        self.testVM.answers.forEach { oneAnswer in
            bool = bool && oneAnswer.text.isEmpty
        }
        return bool
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
