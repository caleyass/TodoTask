//
//  Lab5DatabasePetrovaApp.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//

import SwiftUI

@main
struct Lab5DatabasePetrovaApp: App {
    let persistenceController = CoreDataService.shared

    var body: some Scene {
        WindowGroup {
            TaskView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
