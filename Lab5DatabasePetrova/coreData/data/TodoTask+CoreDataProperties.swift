//
//  TodoTask+CoreDataProperties.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//
//

import Foundation
import CoreData


extension TodoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoTask> {
        return NSFetchRequest<TodoTask>(entityName: "TodoTask")
    }

    @NSManaged public var name: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var dueDate: Date?
    @NSManaged public var subtasks: NSSet?

}

// MARK: Generated accessors for subtasks
extension TodoTask {

    @objc(addSubtasksObject:)
    @NSManaged public func addToSubtasks(_ value: TodoSubtask)

    @objc(removeSubtasksObject:)
    @NSManaged public func removeFromSubtasks(_ value: TodoSubtask)

    @objc(addSubtasks:)
    @NSManaged public func addToSubtasks(_ values: NSSet)

    @objc(removeSubtasks:)
    @NSManaged public func removeFromSubtasks(_ values: NSSet)

}

extension TodoTask : Identifiable {

}
