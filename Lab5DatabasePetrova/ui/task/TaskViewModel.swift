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
    
    func addTask(task: TodoTaskDTO){
        if(tasks.contains(where: { $0.name == task.name })){
            return
        }
        dataService.createTask(task)
        fetchTasks()
    }
    
    func deleteTask(name: String){
        dataService.deleteTask(name: name)
        fetchTasks()
    }
    
    func updateTask(name:String, isDone : Bool){
        dataService.updateTask(name: name, isDone: isDone)
        fetchTasks()
    }
    
    func fetchTasks(){
        self.tasks = dataService.fetchTasks()
    }
    
}
