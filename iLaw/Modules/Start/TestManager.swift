//
//  QuestionModel.swift
//  iLaw
//
//  Created by Evgeniy Safin on 21.01.2023.
//

import Foundation

// MARK: Question model
/*
question model properties:
1. id
2. title
 */

struct QuestionModel: Identifiable {
    
    init(id: UInt8, text: String) {
        self.id = id
        self.text = text
    }
    
    
    let id: UInt8
    var title: String {
        return "Question №\(id)"
    }
    let text: String
}

class TestManager: ObservableObject {
    @Published var questions: [QuestionModel] = []
    
    init() {
        getCard(count: 100)
    }
    
    private func getCard(count: UInt8) {
        (1...count).forEach { index in
            let question = QuestionModel(id: index, text: "text")
            self.questions.append(question)
        }
    }
}
