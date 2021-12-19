//
//  Movies+CoreDataProperties.swift
//  
//
//  Created by Mujahid Ali on 18/12/21.
//
//

import Foundation
import CoreData


extension Movies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movies> {
        return NSFetchRequest<Movies>(entityName: "Movies")
    }

    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var original_title: String?
    @NSManaged public var release_date: String?
    @NSManaged public var original_language: String?
    @NSManaged public var vote_average: Float
    @NSManaged public var backdrop_path: String?
    @NSManaged public var title: String?
    @NSManaged public var poster_path: String?

}
