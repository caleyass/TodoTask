//
//  DatabaseProtocol.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

protocol DatabaseServiceProtocol {
    func createTask(_ task: TodoTaskDTO)
    func fetchTasks() -> [TodoTaskDTO]
    func updateTask(name: String, isDone: Bool)
    func deleteTask(name: String)
    
    func createSubtask(_ taskName: String, subtask: TodoSubtaskDTO)
    func fetchSubtasks(for taskName: String) -> [TodoSubtaskDTO]
    func updateSubtask(name: String, isDone: Bool)
    func deleteSubtask(name: String)
}
