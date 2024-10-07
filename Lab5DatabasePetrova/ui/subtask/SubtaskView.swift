//
//  SubtaskView.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

import SwiftUI

struct SubtaskView : View {
    
    let nameParentTask : String
    
    @ObservedObject var viewModel : SubtaskViewModel
    
    @State private var showAddTaskSheet = false
    @State private var newTaskName = ""
    @State private var newTaskDueDate = Date()
    
    
    init(nameParentTask: String) {
        self.nameParentTask = nameParentTask
        self.viewModel = SubtaskViewModel(nameParentTask: nameParentTask)
        print("Init subtask view with \(nameParentTask)")
    }
    
    var body: some View {
        List {
            ForEach(viewModel.subtasks, id: \.name) { item in
                HStack{
                    Text(item.name)
                    Spacer()
                    CheckboxToggle(
                        isDone: item.isDone,
                        updateValue: { isDone in  viewModel.updateTask(name: item.name, isDone: isDone)}
                    )
                }.padding()
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
        .sheet(isPresented: $showAddTaskSheet) {
            AddSubtaskSheet(addTask: { newTaskName in
                viewModel.addTask(task: TodoSubtaskDTO(name: newTaskName, isDone: false))}, showSheet: $showAddTaskSheet)
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            let task = viewModel.subtasks[index]
            viewModel.deleteTask(name: task.name)
        }
    }
}

struct AddSubtaskSheet: View {
    
    let addTask: (String) -> Void
    
    @Binding var showSheet: Bool
    
    @State private var newTaskName = ""
    @State private var newTaskDueDate = Date()
    
    var body: some View {
        VStack {
            Text("Add New Subtask")
                .font(.headline)
                .padding()
            
            TextField("Subtask Name", text: $newTaskName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            HStack {
                Button("Cancel") {
                    showSheet = false
                }
                .padding()
                
                Spacer()

                Button("Add") {
                    addTask(newTaskName)
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
