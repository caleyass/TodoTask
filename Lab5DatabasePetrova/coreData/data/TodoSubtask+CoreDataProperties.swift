//
//  TodoSubtask+CoreDataProperties.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//
//

import Foundation
import CoreData


extension TodoSubtask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoSubtask> {
        return NSFetchRequest<TodoSubtask>(entityName: "TodoSubtask")
    }

    @NSManaged public var name: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var parent: NSSet?

}

// MARK: Generated accessors for parent
extension TodoSubtask {

    @objc(addParentObject:)
    @NSManaged public func addToParent(_ value: TodoTask)

    @objc(removeParentObject:)
    @NSManaged public func removeFromParent(_ value: TodoTask)

    @objc(addParent:)
    @NSManaged public func addToParent(_ values: NSSet)

    @objc(removeParent:)
    @NSManaged public func removeFromParent(_ values: NSSet)

}

extension TodoSubtask : Identifiable {

}
