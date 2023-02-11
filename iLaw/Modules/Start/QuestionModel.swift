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
    let text: String
    let isValid: Bool
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
