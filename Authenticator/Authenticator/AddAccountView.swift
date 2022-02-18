//
//  AddAccountView.swift
//  Authenticator
//
//  Created by YUKITO on 2022/02/18.
//

import Foundation
import SwiftUI

struct AddAccountView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.id, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State
    var accountName: String = ""
    @State
    var accountDesc: String = ""
    @State
    var key: String = ""
    
    @Binding
    var isPresent: Bool
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Account name", text: $accountName)
                    .frame(alignment: .leading)
                TextField("Description", text: $accountDesc)
                    .frame(alignment: .leading)
                TextField("key", text: $key)
                    .frame(alignment: .leading)
            }
            .navigationTitle("Add account")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel, action: { isPresent.toggle() }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(role: .none, action: save) {
                        Text("Save")
                    }.disabled(!(accountName != "" && key != ""))
                }
            }
        }
    }
    
    func save() {
        isPresent = false
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.title = accountName
            newItem.id = Int64(items.count)
            newItem.desc = accountDesc
            newItem.key = key
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
