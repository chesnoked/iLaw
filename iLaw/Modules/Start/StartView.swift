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
    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 0) {
                CustomNavBar(testVM: testVM, title: "Start", addButton: true)
                QuestionsV2()
            }
        }
        .background(Color.palette.lead)
    }
}

extension StartView {
    private func QuestionsV1() -> some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 10) {
                ForEach(testVM.questions) { question in
                    Text(question.title ?? "")
                        .font(.system(size: 23, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.palette.mercury)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .frame(height: 300)
                        .background(
                            ZStack {
                                Color.white
                                Color.palette.indigo.opacity(0.66).blur(radius: 1.23)
                            }
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                }
            }
        }
        .padding()
    }
}

extension StartView {
    private func Title(_ question: QuestionEntity) -> some View {
        Text(question.title ?? "")
            .font(.system(size: 23, weight: .semibold, design: .rounded))
            .foregroundColor(Color.palette.mercury)
    }
    private func QuestionRow(_ question: QuestionEntity) -> some View {
        VStack(spacing: 10) {
            Title(question)
            // MARK: Text
            Text(question.text ?? "")
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
    private func QuestionsV2() -> some View {
        List {
            ForEach(testVM.questions) { question in
                QuestionRow(question)
            }
            .onMove(perform: { indexSet, newOffset in
                //
            })
            .listRowBackground(Color.palette.lead)
            .listRowSeparator(Visibility.hidden)
        }
        .scrollContentBackground(Visibility.hidden)
    }
}
