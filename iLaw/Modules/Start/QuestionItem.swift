//
//  QuestionItem.swift
//  iLaw
//
//  Created by Evgeniy Safin on 08.02.2023.
//

//struct QuestionItem_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionItem()
//    }
//}

import SwiftUI

struct QuestionItem: View {
    let question: QuestionModel
    var body: some View {
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
        .overlay(alignment: .bottom) {
            Answers()
                .padding(.bottom)
        }
    }
}

extension QuestionItem {
    private func Title(_ question: QuestionModel) -> some View {
        Text(question.title)
            .font(.system(size: 23, weight: .semibold, design: .rounded))
            .foregroundColor(Color.palette.mercury)
    }
    private func Answers() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(question.answers, id: \.self) { answer in
                OneAnswer(answer: answer)
            }
        }
    }
}

struct OneAnswer: View {
    @State private var trigger: Bool? = nil
    let answer: AnswerModel
    var body: some View {
        Text(answer.text)
            .font(.system(size: 16, weight: .light, design: .rounded))
            .foregroundColor(Color.white)
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(
                self.trigger == nil ? Color.palette.lead : self.trigger! ? Color.green : Color.red
            )
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            .onTapGesture {
                if answer.isValid { trigger = true }
                else { trigger = false }
            }
    }
}
