//
//  CDImageData+CoreDataProperties.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//
//

import Foundation
import CoreData


extension CDImageData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDImageData> {
        return NSFetchRequest<CDImageData>(entityName: "CDImageData")
    }

    @NSManaged public var imageContent: Data?
    @NSManaged public var imageDescription: String?
    @NSManaged public var imageName: String?
    @NSManaged public var imageUrl: String?

}

extension CDImageData : Identifiable {

}
