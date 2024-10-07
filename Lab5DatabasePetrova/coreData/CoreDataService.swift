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
    let viewContext : NSManagedObjectContext
    
    init(inMemory: Bool = false) {
        print("Container created")
        container = NSPersistentContainer(name: "Lab5DatabasePetrova")
        viewContext = container.viewContext
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        let description = container.persistentStoreDescriptions.first
        description?.shouldMigrateStoreAutomatically = true
        description?.shouldInferMappingModelAutomatically = true

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
        
        let todoTask = TodoTask(context: viewContext)
        todoTask.name = task.name
        todoTask.isDone = task.isDone
        todoTask.dueDate = task.dueDate
        
        do {
            try viewContext.save()
            print("Successfully saved task \(todoTask.name ?? "")")
        } catch {
            let nsError = error as NSError
            fatalError("Failed to create task \(nsError), \(nsError.userInfo)")
        }
    }
    
    func fetchTasks() -> [TodoTaskDTO] {
        do{
            let todoTasks = try viewContext.fetch(TodoTask.fetchRequest())
            return todoTasks.map { TodoTaskDTO(from: $0) }
            print("Successfully fetched tasks")
        }
        catch{
            print("Failed to fetch tasks: \(error)")
            return []
        }
        
    }
    
    func updateTask(name: String, isDone: Bool) {
        let fetchRequest : NSFetchRequest<TodoTask> = TodoTask.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            
            if let existingTask = results.first {
                existingTask.isDone = isDone
                
                try viewContext.save()
                print("Task \(name) updated successfully")
            } else {
                print("Task not found")
            }
        } catch {
            let nsError = error as NSError
            print("Failed to update task: \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteTask(name: String) {
        let fetchRequest: NSFetchRequest<TodoTask> = TodoTask.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@",name)
        
        do {
            let results = try viewContext.fetch(fetchRequest)

            if let existingTask = results.first {
                
                if let subtasks = existingTask.subtasks as? Set<TodoSubtask> {
                    for subtask in subtasks {
                        viewContext.delete(subtask)
                    }
                }
                
                viewContext.delete(existingTask)
                try viewContext.save()
                print("Task deleted successfully")
            } else {
                print("Task not found")
            }
        } catch {
            let nsError = error as NSError
            print("Failed to delete task: \(nsError), \(nsError.userInfo)")
        }
    }
    
    func createSubtask(_ taskName: String, subtask: TodoSubtaskDTO) {
        let fetchRequest: NSFetchRequest<TodoTask> = TodoTask.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", taskName)

        do {
            if let task = try viewContext.fetch(fetchRequest).first {
                let todoSubtask = TodoSubtask(context: viewContext)
                todoSubtask.name = subtask.name
                todoSubtask.isDone = subtask.isDone
                todoSubtask.parent = task
                print("\(todoSubtask.parent)")
                task.addToSubtasks(todoSubtask)

                try viewContext.save()
                print("Successfully added subtask: \(todoSubtask.name ?? "") with \(todoSubtask.parent?.name ?? "nil") parent")
            }
        } catch {
            let nsError = error as NSError
            fatalError("Failed to create subtask \(nsError), \(nsError.userInfo)")
        }
    }
    
    func fetchSubtasks(for taskName: String) -> [TodoSubtaskDTO] {
        let fetchRequest: NSFetchRequest<TodoSubtask> = TodoSubtask.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "parent.name == %@", taskName)
        
        do {
            let subtasks = try viewContext.fetch(fetchRequest)
            return subtasks.map { TodoSubtaskDTO(name: $0.name ?? "No name", isDone: $0.isDone) }
        }
        catch{
            let nsError = error as NSError
            print("Failed to fetch subtasks: \(nsError), \(nsError.userInfo)")
            return []
        }
    }
    
    func updateSubtask(name: String, isDone: Bool) {
        let fetchRequest: NSFetchRequest<TodoSubtask> = TodoSubtask.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let subtasks = try viewContext.fetch(fetchRequest)
            if let existingTask = subtasks.first {
                existingTask.isDone = isDone
                
                try viewContext.save()
                print("Subtask \(existingTask.name ?? "No name") updated successfully")
            } else {
                print("Task not found")
            }
        }
        catch{
            let nsError = error as NSError
            print("Failed to delete subtask: \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteSubtask(name: String) {
        let fetchRequest: NSFetchRequest<TodoSubtask> = TodoSubtask.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let subtasks = try viewContext.fetch(fetchRequest)
            if let existingTask = subtasks.first {
                existingTask.parent?.removeFromSubtasks(existingTask)
                viewContext.delete(existingTask)
                try viewContext.save()
                print("Subtask \(existingTask.name ?? "No name") deleted successfully")
            } else {
                print("Task not found")
            }
        }
        catch{
            let nsError = error as NSError
            print("Failed to delete subtask: \(nsError), \(nsError.userInfo)")
        }
    }

}
