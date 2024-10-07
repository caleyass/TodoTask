//
//  ContentView.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

import SwiftUI
import CoreData

struct TaskView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel = TaskViewModel()
    
    @State private var showAddTaskSheet = false
    @State private var newTaskName = ""
    @State private var newTaskDueDate = Date()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks, id: \.name) { item in
                    NavigationLink {
                        LazyView {
                            SubtaskView(nameParentTask: item.name)
                        }
                    } label: {
                        HStack{
                            VStack(alignment: .leading) {
                                Text(item.name)
                                Text("Due: \(formattedDate(item.dueDate))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            CheckboxToggle(
                                isDone: item.isDone,
                                updateValue: { isDone in  viewModel.updateTask(name: item.name, isDone: isDone)}
                            )
                        }.padding()
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showAddTaskSheet = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showAddTaskSheet) {
            AddTaskSheet(addTask: { newTaskName, newTaskDueDate in
                viewModel.addTask(task: TodoTaskDTO(name: newTaskName, isDone: false, dueDate: newTaskDueDate, subtasks: []))
            }, showSheet: $showAddTaskSheet)
        }
    }
        
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            let task = viewModel.tasks[index]
            viewModel.deleteTask(name: task.name)
        }
    }
    
    private func formattedDate(_ date: Date?) -> String {
      guard let date = date else { return "No due date" }
      let formatter = DateFormatter()
      formatter.dateStyle = .medium
      return formatter.string(from: date)
  }
    
}

struct AddTaskSheet: View {
    
    let addTask: (String, Date) -> Void
    
    @Binding var showSheet: Bool
    
    @State private var newTaskName = ""
    @State private var newTaskDueDate = Date()
    
    var body: some View {
        VStack {
            Text("Add New Task")
                .font(.headline)
                .padding()
            
            TextField("Task Name", text: $newTaskName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            DatePicker("Due Date", selection: $newTaskDueDate, displayedComponents: [.date])
                .padding()

            HStack {
                Button("Cancel") {
                    showSheet = false
                }
                .padding()
                
                Spacer()

                Button("Add") {
                    addTask(newTaskName, newTaskDueDate)
                    newTaskName = ""
                    newTaskDueDate = Date()
                    showSheet = false
                }
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    TaskView().environment(\.managedObjectContext, CoreDataService.preview.container.viewContext)
}


//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
