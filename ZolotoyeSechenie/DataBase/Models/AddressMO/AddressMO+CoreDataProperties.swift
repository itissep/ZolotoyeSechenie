//
//  AddressMO+CoreDataProperties.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 11.04.2023.
//
//

import Foundation
import CoreData


extension AddressMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddressMO> {
        return NSFetchRequest<AddressMO>(entityName: "AddressMO")
    }

    @NSManaged public var id: String?
    @NSManaged public var city: String?
    @NSManaged public var disctrict: String?
    @NSManaged public var street: String?
    @NSManaged public var building: String?
    @NSManaged public var apartment: String?
    @NSManaged public var comment: String?
    @NSManaged public var userId: String?

}

extension AddressMO : Identifiable {

}
