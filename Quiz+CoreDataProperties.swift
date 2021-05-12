//
//  Quiz+CoreDataProperties.swift
//  Project_2
//
//  Created by admin on 5/11/21.
//
//

import Foundation
import CoreData


extension Quiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quiz> {
        return NSFetchRequest<Quiz>(entityName: "Quiz")
    }

    @NSManaged public var name: String?
    @NSManaged public var questions: Double
    @NSManaged public var ztoq: NSSet?

}

// MARK: Generated accessors for ztoq
extension Quiz {

    @objc(addZtoqObject:)
    @NSManaged public func addToZtoq(_ value: Question)

    @objc(removeZtoqObject:)
    @NSManaged public func removeFromZtoq(_ value: Question)

    @objc(addZtoq:)
    @NSManaged public func addToZtoq(_ values: NSSet)

    @objc(removeZtoq:)
    @NSManaged public func removeFromZtoq(_ values: NSSet)

}

extension Quiz : Identifiable {

}
