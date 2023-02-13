//
//  QuestionModel.swift
//  iLaw
//
//  Created by Evgeniy Safin on 11.02.2023.
//

import Foundation

struct AnswerModel: Identifiable {
    
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
}

struct QuestionModel: Identifiable {
    
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
