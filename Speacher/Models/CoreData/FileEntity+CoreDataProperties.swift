//
//  FileEntity+CoreDataProperties.swift
//  Speacher
//
//  Created by Vadim on 9/9/22.
//
//

import Foundation
import CoreData


extension FileEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FileEntity> {
        return NSFetchRequest<FileEntity>(entityName: "FileEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var language: String?
    @NSManaged public var readingTime: Int64
    @NSManaged public var titleImage: Data?
    @NSManaged public var paragraphs: [String]?
    @NSManaged public var chapters: Set<ChapterEntity>
    
    public var chaptersT: [ChapterEntity] {
        let chp = chapters
        return Array(chp)
    }

}

// MARK: Generated accessors for chapters
extension FileEntity {

    @objc(addChaptersObject:)
    @NSManaged public func addToChapters(_ value: ChapterEntity)

    @objc(removeChaptersObject:)
    @NSManaged public func removeFromChapters(_ value: ChapterEntity)

    @objc(addChapters:)
    @NSManaged public func addToChapters(_ values: NSSet)

    @objc(removeChapters:)
    @NSManaged public func removeFromChapters(_ values: NSSet)

}

extension FileEntity : Identifiable {

}
