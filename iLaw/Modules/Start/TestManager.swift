//
//  QuestionModel.swift
//  iLaw
//
//  Created by Evgeniy Safin on 21.01.2023.
//

import Foundation
import SwiftUI
import CoreData

// MARK: Question model
/*
question model properties:
1. id
2. title
 */

struct QuestionModel: Identifiable, Codable {
    
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
    
//    @Published var questions: [QuestionModel] = []
    
    // MARK: Use core data
    @Published var questions: [QuestionEntity] = []
    
    let coreDataManager = CoreDataManager.shared
    
    init() {
//        saveCards(count: 100)
        fetchCards()
    }
    
    func addQuestion(id: Int16, text: String) {
        let newQuestion = QuestionEntity(context: coreDataManager.context)
        newQuestion.id = id
        newQuestion.title = "Question №\(id)"
        newQuestion.text = text
        save()
        fetchCards()
    }
    
    // get questions from core data
    private func fetchCards() {
    
        let request = NSFetchRequest<QuestionEntity>(entityName: "QuestionEntity")
        
        do {
            self.questions = try coreDataManager.context.fetch(request)
        } catch let error {
            print("Error fetch cards from Core Data : \(error.localizedDescription)")
        }
        
    }
    
    // save to core data on start
    private func saveCards(count: Int16) {
        (1...count).forEach { index in
            // MARK: Old method
//            let question = QuestionModel(id: index, text: "text")
//            self.questions.append(question)
            // MARK: Core data
            let question = QuestionEntity(context: coreDataManager.context)
            question.id = index
            question.title = "Question №\(index)"
            question.text = "text"
            
            save()
        }
    }
    
    private func save() {
        coreDataManager.save()
    }
}
