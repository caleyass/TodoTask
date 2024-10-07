//
//  SubtaskViewModel.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

import SwiftUI

// todo optimize
class SubtaskViewModel: ObservableObject {
    
    @Published var subtasks: [TodoSubtaskDTO] = []
    
    let nameParentTask : String

    init(nameParentTask:String) {
        self.nameParentTask = nameParentTask
        self.subtasks = dataService.fetchSubtasks(for: nameParentTask)
    }
    
    func addTask(task: TodoSubtaskDTO){
        if(subtasks.contains(where: { $0.name == task.name })){
            return
        }
        dataService.createSubtask(nameParentTask, subtask: task)
        fetchSubtasks()
    }
    
    func deleteTask(name: String){
        dataService.deleteSubtask(name: name)
        fetchSubtasks()
    }
    
    func updateTask(name:String, isDone : Bool){
        dataService.updateSubtask(name: name, isDone: isDone)
        fetchSubtasks()
    }
    
    func fetchSubtasks(){
        self.subtasks = dataService.fetchSubtasks(for: nameParentTask)
    }
    
    
}
