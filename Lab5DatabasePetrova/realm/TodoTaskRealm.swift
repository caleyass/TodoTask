//
//  TodoTaskRealm.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//
import RealmSwift
import Foundation

class TodoTaskRealm : Object, Identifiable {
    @objc dynamic var name: String = ""
    @objc dynamic var isDone: Bool = false
    @objc dynamic var dueDate: Date = Date()
    
    let subtasks = List<TodoSubtaskRealm>()
}
