//
//  AuthenticatorApp.swift
//  Authenticator
//
//  Created by YUKITO on 2022/02/17.
//

import SwiftUI

@main
struct AuthenticatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
