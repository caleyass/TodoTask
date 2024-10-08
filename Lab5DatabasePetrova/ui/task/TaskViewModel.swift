//
//  MainViewModel.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    
    @Published var tasks: [TodoTaskDTO] = []
    
    init() {
        self.tasks = dataService.fetchTasks()
    }
    
    func addTask(task: TodoTaskDTO) {
        if tasks.contains(where: { $0.name == task.name }) {
            return
        }
        tasks.append(task)
        dataService.createTask(task)
    }
    
    func deleteTask(name: String) {
        tasks.removeAll { $0.name == name }
        dataService.deleteTask(name: name)
    }
    
    func updateTask(name: String, isDone: Bool) {
        if let index = tasks.firstIndex(where: { $0.name == name }) {
            tasks[index].isDone = isDone
        }
        dataService.updateTask(name: name, isDone: isDone)
    }
}

