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
    @State private var goToText: String = ""
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
                GoTo()
                Spacer()
                Reset()
                Spacer()
                AddButton()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.palette.indigo)
        .divider(.bottom)
    }
    private func GoTo() -> some View {
        TextField("№", text: $goToText)
            .font(.system(size: 24, weight: .regular, design: .rounded))
            .foregroundColor(Color.palette.mercury)
            .padding(5)
            .frame(width: 100)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            .environment(\.colorScheme, .light)
    }
    private func Reset() -> some View {
        Button(action: {
            testVM.reset()
        }, label: {
            Image(systemName: "arrow.triangle.2.circlepath")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(Color.palette.mercury)
        })
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
              !testVM.answersTextIsEmpty()
        else {
            self.id = ""
            self.text = ""
            return
        }
        testVM.addQuestion(id, text, self.testVM.answers)
    }
}

extension StartView {
    private func Questions() -> some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(testVM.questions) { question in
                        QuestionItem(question: question)
                            .id(question)
                    }
                }
                .padding()
            }
            .onChange(of: self.goToText) { newText in
                guard let number = Int16(newText),
                      let question = getQuestion(number)
                else { return }
                withAnimation(.spring()) {
                    proxy.scrollTo(question, anchor: .center)
                }
            }
        }
    }
    private func getQuestion(_ number: Int16) -> QuestionModel? {
        return testVM.questions.first { oneQuestionModel in
            oneQuestionModel.id == number
        }
    }
}
