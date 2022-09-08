//
//  SpeacherApp.swift
//  Speacher
//
//  Created by Vadim on 9/8/22.
//

import SwiftUI

@main
struct SpeacherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
