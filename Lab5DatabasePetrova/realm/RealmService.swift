//
//  ReakmService.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

import RealmSwift

class RealmDatabaseService: DatabaseServiceProtocol {
        
    private var realm: Realm {
        return try! Realm()
    }

    func createTask(_ task: TodoTaskDTO) {
        let todoTask = TodoTaskRealm()
        todoTask.name = task.name
        todoTask.isDone = task.isDone
        todoTask.dueDate = task.dueDate
        
        try! realm.write {
            realm.add(todoTask)
        }
    }

    func fetchTasks() -> [TodoTaskDTO] {
        let todoTasks = realm.objects(TodoTaskRealm.self)
        return todoTasks.map { TodoTaskDTO(name: $0.name, isDone: $0.isDone, dueDate: $0.dueDate, subtasks: []) }
    }

    func updateTask(name: String, isDone: Bool) {
        let task = realm.objects(TodoTaskRealm.self).filter("name == %@", name).first
        
        if let existingTask = task {
            try! realm.write {
                existingTask.isDone = isDone
            }
        }
    }

    func deleteTask(name: String) {
        let task = realm.objects(TodoTaskRealm.self).filter("name == %@", name).first
        
        if let existingTask = task {
            try! realm.write {
                realm.delete(existingTask.subtasks)
                realm.delete(existingTask)
            }
        }
    }

    func createSubtask(_ taskName: String, subtask: TodoSubtaskDTO) {
        let task = realm.objects(TodoTaskRealm.self).filter("name == %@", taskName).first
        
        if let existingTask = task {
            let todoSubtask = TodoSubtaskRealm()
            todoSubtask.name = subtask.name
            todoSubtask.isDone = subtask.isDone
            
            try! realm.write {
                existingTask.subtasks.append(todoSubtask)
            }
        }
    }

    func fetchSubtasks(for taskName: String) -> [TodoSubtaskDTO] {
        let subtasks = realm.objects(TodoTaskRealm.self).filter("name == %@", taskName).first?.subtasks ?? List<TodoSubtaskRealm>()
        return subtasks.map { TodoSubtaskDTO(name: $0.name, isDone: $0.isDone) }
    }

    func updateSubtask(name: String, isDone: Bool) {
        let subtask = realm.objects(TodoSubtaskRealm.self).filter("name == %@", name).first
        
        if let existingSubtask = subtask {
            try! realm.write {
                existingSubtask.isDone = isDone
            }
        }
    }

    func deleteSubtask(name: String) {
        let subtask = realm.objects(TodoSubtaskRealm.self).filter("name == %@", name).first
        
        if let existingSubtask = subtask {
            try! realm.write {
                realm.delete(existingSubtask)
            }
        }
    }
}
