//
//  TodoSubtaskSwift.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//
import SwiftData

@Model
class TodoSubtaskSwiftData {
    var name: String
    var isDone: Bool

    init(name: String, isDone: Bool) {
        self.name = name
        self.isDone = isDone
    }
}
