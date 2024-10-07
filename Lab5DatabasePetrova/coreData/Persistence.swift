//
//  Persistence.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

import CoreData

struct CoreDataService : DatabaseServiceProtocol {
    
    
    static let shared = CoreDataService()

    @MainActor
    static let preview: CoreDataService = {
        let result = CoreDataService(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let todoTask = TodoTask(context: viewContext)
            todoTask.name = "Task \(i)"
            todoTask.isDone = false
            todoTask.dueDate = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Lab5DatabasePetrova")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func createTask(_ task: TodoTaskDTO) {
        let viewContext = container.viewContext
        let todoTask = TodoTask(context: viewContext)
        todoTask.name = task.name
        todoTask.isDone = task.isDone
        todoTask.dueDate = task.dueDate
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func fetchTasks() -> [TodoTaskDTO] {
        <#code#>
    }
    
    func updateTask(_ task: TodoTaskDTO) {
        <#code#>
    }
    
    func deleteTask(_ task: TodoTaskDTO) {
        <#code#>
    }
    
    func createSubtask(_ taskID: Int, subtask: TodoSubtaskDTO) {
        <#code#>
    }
    
    func fetchSubtasks(for taskID: Int) -> [TodoSubtaskDTO] {
        <#code#>
    }
    
    func updateSubtask(_ subtask: TodoSubtaskDTO) {
        <#code#>
    }
    
    func deleteSubtask(_ subtask: TodoSubtaskDTO) {
        <#code#>
    }

}
