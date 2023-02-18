//
//  QuestionEntity+CoreDataProperties.swift
//  
//
//  Created by Evgeniy Safin on 11.02.2023.
//
//

import Foundation
import CoreData

@objc(QuestionEntity)
public class QuestionEntity: NSManagedObject {

}

extension QuestionEntity: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionEntity> {
        return NSFetchRequest<QuestionEntity>(entityName: "QuestionEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var text: String?
    @NSManaged public var answers: NSSet?
    
    public var answersArray: [AnswerEntity]? {
        guard let set = answers as? Set<AnswerEntity> else { return nil }
        return set.sorted { $0.id < $1.id }
    }

}

// MARK: Generated accessors for answers
extension QuestionEntity {

    @objc(addAnswersObject:)
    @NSManaged public func addToAnswers(_ value: AnswerEntity)

    @objc(removeAnswersObject:)
    @NSManaged public func removeFromAnswers(_ value: AnswerEntity)

    @objc(addAnswers:)
    @NSManaged public func addToAnswers(_ values: NSSet)

    @objc(removeAnswers:)
    @NSManaged public func removeFromAnswers(_ values: NSSet)

}
