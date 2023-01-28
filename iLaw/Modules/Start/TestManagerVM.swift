//
//  QuestionModel.swift
//  iLaw
//
//  Created by Evgeniy Safin on 21.01.2023.
//

import Foundation
import SwiftUI
import CoreData
import Combine

// MARK: Question model
struct QuestionModel: Identifiable {
    
    init(id: Int16, text: String) {
        self.id = id
        self.text = text
    }
    
    
    let id: Int16
    var title: String {
        return "Question №\(id)"
    }
    let text: String
}

// MARK: View model
class TestManager: ObservableObject {
    
    private let manager = CoreDataManager()
    
    @Published var questions: [QuestionModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getQuestions()
    }
    
    // for questions
    private func getQuestions() {
        manager.$questions
            .map(transform)
            .sink { questions in
                self.questions = questions
            }
            .store(in: &cancellables)
    }
    private func transform(questions: [QuestionEntity]) -> [QuestionModel] {
        guard !questions.isEmpty else { return [] }
        var originQuestions = [QuestionModel]()
        questions.forEach { questionEntity in
            guard let text = questionEntity.text
            else { return }
            let question = QuestionModel(id: questionEntity.id, text: text)
            originQuestions.append(question)
        }
        return originQuestions
    }
    
    // for question
    func addQuestion(_ id: Int16, _ text: String) {
        manager.addQuestion(id, text: text)
    }
    
}