//
//  User+CoreDataProperties.swift
//  Project_2
//
//  Created by admin on 5/11/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var score: Double
    @NSManaged public var username: String?
    @NSManaged public var block: Bool
    @NSManaged public var score2: Double

}

extension User : Identifiable {

}
