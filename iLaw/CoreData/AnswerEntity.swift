//
//  AnswerEntity+CoreDataProperties.swift
//  
//
//  Created by Evgeniy Safin on 11.02.2023.
//
//

import Foundation
import CoreData

@objc(AnswerEntity)
public class AnswerEntity: NSManagedObject {

}

extension AnswerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnswerEntity> {
        return NSFetchRequest<AnswerEntity>(entityName: "AnswerEntity")
    }

    @NSManaged public var text: String?
    @NSManaged public var isValid: Bool
    @NSManaged public var id: Int16
    @NSManaged public var question: QuestionEntity?

}
