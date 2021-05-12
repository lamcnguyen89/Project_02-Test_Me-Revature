//
//  Question+CoreDataProperties.swift
//  
//
//  Created by admin on 5/12/21.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var ans1: String?
    @NSManaged public var ans2: String?
    @NSManaged public var ans3: String?
    @NSManaged public var ans4: String?
    @NSManaged public var cans: String?
    @NSManaged public var qid: String?
    @NSManaged public var questions: String?
    @NSManaged public var qtoz: NSSet?

}

// MARK: Generated accessors for qtoz
extension Question {

    @objc(addQtozObject:)
    @NSManaged public func addToQtoz(_ value: Quiz)

    @objc(removeQtozObject:)
    @NSManaged public func removeFromQtoz(_ value: Quiz)

    @objc(addQtoz:)
    @NSManaged public func addToQtoz(_ values: NSSet)

    @objc(removeQtoz:)
    @NSManaged public func removeFromQtoz(_ values: NSSet)

}
