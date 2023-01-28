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
    var body: some View {
        VStack(spacing: 0) {
            NavBar()
            ZStack {
                if showDropMenu {
                    DropMenu()
                        .padding()
                } else {
                    QuestionsList()
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
        VStack(alignment: .leading) {
            TextField("id", text: $id)
                .font(.headline)
                .foregroundColor(Color.black)
                .environment(\.colorScheme, .light)
                .padding(5)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                .frame(maxWidth: 50)
            TextEditor(text: $text)
                .environment(\.colorScheme, .light)
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                .overlay(alignment: .topLeading) {
                    Text(self.text.isEmpty ? "text" : "")
                        .font(.headline)
                        .foregroundColor(.black)
                        .opacity(0.3)
                        .padding(3)
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension StartView {
    private func QuestionsList() -> some View {
        List {
            ForEach(testVM.questions) { question in
                QuestionRow(question)
            }
            .listRowBackground(Color.palette.lead)
            .listRowSeparator(Visibility.hidden)
        }
        .scrollContentBackground(Visibility.hidden)
    }
    private func QuestionRow(_ question: QuestionModel) -> some View {
        VStack(spacing: 10) {
            Title(question)
            Text(question.text)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 300, alignment: .top)
        .background(
            ZStack {
                Color.white
                Color.palette.indigo.opacity(0.66).blur(radius: 1.23)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
    }
    private func Title(_ question: QuestionModel) -> some View {
        Text(question.title)
            .font(.system(size: 23, weight: .semibold, design: .rounded))
            .foregroundColor(Color.palette.mercury)
    }
}
