//
//  QuestionModel.swift
//  iLaw
//
//  Created by Evgeniy Safin on 11.02.2023.
//

import Foundation

struct AnswerModel: Identifiable, Hashable {
    
    // conform to Equatable
    static func == (lhs: AnswerModel, rhs: AnswerModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    // conform to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(text)
        hasher.combine(isValid)
    }
    
    init(id: Int16, text: String, isValid: Bool) {
        self.id = id
        self.text = text
        self.isValid = isValid
    }
    
    let id: Int16
    var text: String
    var isValid: Bool
}

extension AnswerModel {
    static let answers: [AnswerModel] = [
        AnswerModel(id: 1, text: "", isValid: false),
        AnswerModel(id: 2, text: "", isValid: false),
        AnswerModel(id: 3, text: "", isValid: false),
        AnswerModel(id: 4, text: "", isValid: false)
    ]
    static let randomAnswers: [AnswerModel] = [
        AnswerModel(id: 1, text: "answer 1", isValid: Bool.random()),
        AnswerModel(id: 2, text: "answer 2", isValid: Bool.random()),
        AnswerModel(id: 3, text: "answer 3", isValid: Bool.random()),
        AnswerModel(id: 4, text: "answer 4", isValid: Bool.random())
    ]
}

struct QuestionModel: Identifiable, Hashable {
    
    // conform to Equatable
    static func == (lhs: QuestionModel, rhs: QuestionModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    // conform to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(text)
        answers.forEach { oneAnswer in
            hasher.combine(oneAnswer)
        }
    }
    
    init(id: Int16, text: String, answers: [AnswerModel] = []) {
        self.id = id
        self.text = text
        self.answers = answers
    }
    
    let id: Int16
    let text: String
    let answers: [AnswerModel]
    
    var title: String {
        return "Question №\(id)"
    }
    
}

extension QuestionModel {
    static let questionsStart: [QuestionModel] = [
        QuestionModel(id: 1, text: "question 1 text", answers: AnswerModel.randomAnswers),
        QuestionModel(id: 2, text: "question 2 text", answers: AnswerModel.randomAnswers),
        QuestionModel(id: 3, text: "question 3 text", answers: AnswerModel.randomAnswers)
    ]
}
