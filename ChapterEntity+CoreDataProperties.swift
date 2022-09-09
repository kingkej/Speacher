//
//  ChapterEntity+CoreDataProperties.swift
//  Speacher
//
//  Created by Vadim on 9/9/22.
//
//

import Foundation
import CoreData


extension ChapterEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChapterEntity> {
        return NSFetchRequest<ChapterEntity>(entityName: "ChapterEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var paragraphs: [String]?
    @NSManaged public var chapter: NSManagedObject?

}

extension ChapterEntity : Identifiable {

}
