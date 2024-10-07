//
//  TodoSubtaskDTO.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

import CoreData


struct TodoSubtaskDTO : Identifiable {
    var id: String { name }
    var name: String
    var isDone: Bool
}

extension TodoSubtaskDTO {

    init(from todoSubtask: TodoSubtask) {
        self.name = todoSubtask.name ?? "No Name"
        self.isDone = todoSubtask.isDone
    }
    
    func toDatabaseObject(context : NSManagedObjectContext) -> TodoSubtask {
        let task = TodoSubtask(context: context)
        task.name = name
        task.isDone = isDone
        return task
    }
}


