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
    @NSManaged public var parent: TodoTask?

}

extension TodoSubtask : Identifiable {
    
    
    
}
