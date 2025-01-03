//
//  TodoTaskSwift.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//
import SwiftData
import Foundation

@Model
class TodoTaskSwiftData {
    var name: String
    var isDone: Bool
    var dueDate: Date
    var subtasks: [TodoSubtaskSwiftData]

    init(name: String, isDone: Bool, dueDate: Date, subtasks: [TodoSubtaskSwiftData] = []) {
        self.name = name
        self.isDone = isDone
        self.dueDate = dueDate
        self.subtasks = subtasks
    }
}
