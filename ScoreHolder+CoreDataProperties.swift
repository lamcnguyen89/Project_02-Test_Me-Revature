//
//  ScoreHolder+CoreDataProperties.swift
//  
//
//  Created by Lam Nguyen on 5/14/21.
//
//

import Foundation
import CoreData


extension ScoreHolder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScoreHolder> {
        return NSFetchRequest<ScoreHolder>(entityName: "ScoreHolder")
    }

    @NSManaged public var quiz: String?
    @NSManaged public var score: Double
    @NSManaged public var user: String?

}
