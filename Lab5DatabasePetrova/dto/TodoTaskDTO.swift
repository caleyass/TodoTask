//
//  TodoTask.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

import Foundation
import CoreData

struct TodoTaskDTO {
    var id: String { name }
    var name: String
    var isDone: Bool
    var dueDate: Date
    var subtasks: [TodoSubtaskDTO]
}

extension TodoTaskDTO {

    init(from todoTask: TodoTask) {
        self.name = todoTask.name ?? "No Name"
        self.isDone = todoTask.isDone
        self.dueDate = todoTask.dueDate ?? Date()
        if let subtasksSet = todoTask.subtasks as? Set<TodoSubtask> {
           self.subtasks = subtasksSet.compactMap { TodoSubtaskDTO(from: $0) }
       } else {
           self.subtasks = []
       }
    }
    
    func toDatabaseObject(context : NSManagedObjectContext) -> TodoTask {
        let task = TodoTask(context: context)
        task.name = name
        task.isDone = isDone
        task.dueDate = dueDate
        return task
    }
}
