//
//  ContentView.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel = TaskViewModel()
    
    @State private var showAddTaskAlert = false
    @State private var newTaskName = ""
    @State private var newTaskDueDate = Date()
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks, id: \.name) { item in
                    NavigationLink {
                        Text("\(item.name)")
                    } label: {
                        HStack{
                            Text("\(item.name ?? "no name")")
                            Spacer()
                            CheckboxToggle(
                                isDone: item.isDone,
                                updateValue: { isDone in  viewModel.updateTask(name: item.name, isDone: isDone)}
                            )
                        }.padding()
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        viewModel.addTask(task: TodoTaskDTO(name: "new task", isDone: false, dueDate: Date(), subtasks: []))
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                
            }
            Text("Select an item")
        }
    }
}


struct CheckboxToggle : View {
    @State var isDone : Bool
    let updateValue : (Bool) -> Void
    
    var body: some View{
        Image(systemName: isDone ? "checkmark.square" : "square")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(.black)
            .onTapGesture {
                isDone.toggle()
                updateValue(isDone)
            }
    }
}



#Preview {
    ContentView().environment(\.managedObjectContext, CoreDataService.preview.container.viewContext)
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
