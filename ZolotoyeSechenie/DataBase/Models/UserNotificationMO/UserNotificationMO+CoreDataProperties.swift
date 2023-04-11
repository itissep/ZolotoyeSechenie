//
//  UserNotificationMO+CoreDataProperties.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 11.04.2023.
//
//

import Foundation
import CoreData


extension UserNotificationMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserNotificationMO> {
        return NSFetchRequest<UserNotificationMO>(entityName: "UserNotificationMO")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var message: String?
    @NSManaged public var image: String?
    @NSManaged public var date: Date?

}

extension UserNotificationMO : Identifiable {

}
