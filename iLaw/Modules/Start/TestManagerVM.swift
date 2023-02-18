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

// MARK: View model
class TestManager: ObservableObject {
    
    private let manager = CoreDataManager()
    
    @Published var questions: [QuestionModel] = []
    @Published var newQuestion: QuestionModel? = nil
    private var cancellables = Set<AnyCancellable>()
    
    @Published var amount: Int = 4
    @Published var answers: [AnswerModel] = []
    
    init() {
        getQuestions()
        getAnswers()
    }
    
    func reset() {
        manager.reset()
    }
    
    private func getAnswers() {
        self.answers = AnswerModel.answers
    }
    
    func answersTextIsEmpty() -> Bool {
        guard !answers.isEmpty else { return false }
        var bool = true
        answers.forEach { oneAnswer in
            bool = bool && !oneAnswer.text.isEmpty
        }
        return !bool
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
    
    // Question Entity properties
    /*
    @NSManaged public var id: Int16
    @NSManaged public var text: String?
    @NSManaged public var answers: NSSet?
     */
    
    /* // Answer Entity properties
     @NSManaged public var text: String?
     @NSManaged public var isValid: Bool
     @NSManaged public var id: Int16
     @NSManaged public var question: QuestionEntity?
     */
    
    private func transform(questions: [QuestionEntity]) -> [QuestionModel] {
        guard !questions.isEmpty else { return [] }
        var originQuestions = [QuestionModel]()
        questions.forEach { questionEntity in
            guard let text = questionEntity.text,
                  let answersEntities = questionEntity.answersArray
            else { return }
            
            var answers = [AnswerModel]()
            answersEntities.forEach { oneAnswerEntity in
                guard let text = oneAnswerEntity.text
                else { return }
                      
                let answer = AnswerModel(id: oneAnswerEntity.id, text: text, isValid: oneAnswerEntity.isValid)
                answers.append(answer)
            }
            // MARK: here
            let question = QuestionModel(id: questionEntity.id, text: text, answers: answers)
            originQuestions.append(question)
        }
        return originQuestions
    }
    
    // for question
    func addQuestion(_ id: Int16, _ text: String, _ answers: [AnswerModel]) {
        var answersEntities = [AnswerEntity]()
        answers.forEach { oneAnswerModel in
            let answer = AnswerEntity(context: self.manager.container.viewContext)
            answer.id = oneAnswerModel.id
            answer.text = oneAnswerModel.text
            answer.isValid = oneAnswerModel.isValid
            answersEntities.append(answer)
            self.manager.applyChanges()
        }
        
        manager.addQuestion(id, text, answersEntities)
    }
}
