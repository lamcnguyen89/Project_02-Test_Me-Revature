//
//  ScoreHolder+CoreDataProperties.swift
//  
//
//  Created by admin on 5/13/21.
//
//

import Foundation
import CoreData


extension ScoreHolder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScoreHolder> {
        return NSFetchRequest<ScoreHolder>(entityName: "ScoreHolder")
    }

    @NSManaged public var user: String?
    @NSManaged public var quiz: String?
    @NSManaged public var score: Double

}
