//
//  iMakeBetter_TestApp.swift
//  iMakeBetter_Test
//
//  Created by Vova on 15/11/2023.
//

import SwiftUI

@main
struct iMakeBetter_TestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
