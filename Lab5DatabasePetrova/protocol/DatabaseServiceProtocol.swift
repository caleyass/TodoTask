//
//  DatabaseProtocol.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

protocol DatabaseServiceProtocol {
    func createTask(_ task: TodoTaskDTO)
    func fetchTasks() -> [TodoTaskDTO]
    func updateTask(_ task: TodoTaskDTO)
    func deleteTask(_ task: TodoTaskDTO)
    
    func createSubtask(_ taskID: Int, subtask: TodoSubtaskDTO)
    func fetchSubtasks(for taskID: Int) -> [TodoSubtaskDTO]
    func updateSubtask(_ subtask: TodoSubtaskDTO)
    func deleteSubtask(_ subtask: TodoSubtaskDTO)
}
