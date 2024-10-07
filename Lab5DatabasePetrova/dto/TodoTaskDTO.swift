//
//  TodoTask.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

import Foundation

struct TodoTaskDTO {
    var name: String
    var isDone: Bool
    var dueDate: Date
    var subtasks: [TodoSubtask]
}
