//
//  CoreDataManager.swift
//  iLaw
//
//  Created by Evgeniy Safin on 24.01.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    @Published var questions: [QuestionEntity] = []
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "MyContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading from Core Data : \(error.localizedDescription)")
            }
        }
        fetchQuestions()
    }

    private func fetchQuestions() {
        let request = NSFetchRequest<QuestionEntity>(entityName: "QuestionEntity")
        do {
            self.questions = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetch questions from Core Data : \(error.localizedDescription)")
        }
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data : \(error.localizedDescription)")
        }
    }
    
    func applyChanges() {
        save()
        fetchQuestions()
    }
    
    // get questions on start
    private func getQuestionsOnStart(count: Int16) {
        (1...count).forEach { index in
            let question = QuestionEntity(context: container.viewContext)
            question.id = index
            question.text = "text"
            save()
        }
    }
    
    func addQuestion(_ id: Int16, _ text: String, _ answers: [AnswerEntity]) {
        let question = QuestionEntity(context: container.viewContext)
        question.id = id
        question.text = text
        
        answers.forEach { oneAnswerEntity in
            self.addAnswer(question, oneAnswerEntity)
            applyChanges()
        }
    }
    func addAnswer(_ question: QuestionEntity, _ answer: AnswerEntity) {
        question.addToAnswers(answer)
    }
}
