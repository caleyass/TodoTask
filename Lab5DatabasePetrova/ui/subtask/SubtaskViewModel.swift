//
//  SubtaskViewModel.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

import SwiftUI

class SubtaskViewModel: ObservableObject {
    
    @Published var subtasks: [TodoSubtaskDTO] = []
    
    let nameParentTask: String

    init(nameParentTask: String) {
        self.nameParentTask = nameParentTask
        self.subtasks = dataService.fetchSubtasks(for: nameParentTask)
    }
    
    func addTask(task: TodoSubtaskDTO) {
        if subtasks.contains(where: { $0.name == task.name }) {
            return
        }
        subtasks.append(task)
        dataService.createSubtask(nameParentTask, subtask: task)
    }
    
    func deleteTask(name: String) {
        subtasks.removeAll { $0.name == name }
        dataService.deleteSubtask(name: name)
    }
    
    func updateTask(name: String, isDone: Bool) {
        if let index = subtasks.firstIndex(where: { $0.name == name }) {
            subtasks[index].isDone = isDone
        }
        dataService.updateSubtask(name: name, isDone: isDone)
    }
    
}
