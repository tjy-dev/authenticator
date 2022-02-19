//
//  EditAccountView.swift
//  Authenticator
//
//  Created by YUKITO on 2022/02/18.
//

import Foundation
import SwiftUI

struct EditAccountView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.id, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State
    var accountName: String
    
    @State
    var accountDesc: String
    
    @State
    var key: String
    
    @Binding
    var isPresented: Bool
    
    private
    var id = 0
    
    init(data: CodeItem, isPresented: Binding<Bool>) {
        _isPresented = isPresented
        _accountName = State(initialValue: data.title)
        _accountDesc = State(initialValue: data.desc ?? "")
        _key = State(initialValue: data.key)
        id = data.id
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Account name", text: $accountName)
                        .frame(alignment: .leading)
                    TextField("Description", text: $accountDesc)
                        .frame(alignment: .leading)
#if DEBUG
                    TextField("key", text: $key)
                        .frame(alignment: .leading)
#endif
                }
                Section {
                    Button {
                        delete()
                    } label: {
                        Text("delete")
                    }
                }
            }
            .navigationTitle("Add account")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(role: .none, action: save) {
                        Text("Save")
                    }.disabled(!(accountName != "" && key != ""))
                }
            }
        }
    }
    
    func save() {
        isPresented.toggle()
        
        let newItem = items[id]
        newItem.timestamp = Date()
        newItem.title = accountName
        newItem.desc = accountDesc
        newItem.key = key
        
        do {
            try viewContext.save()
        } catch {
#if DEBUG
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
#endif
        }
    }
    
    func delete() {
        isPresented.toggle()
        
        let item = items[id]
        viewContext.delete(item)
        
        for i in 0..<items.count {
            items[i].id = Int64(i)
        }
        do {
            try viewContext.save()
        } catch {
#if DEBUG
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
#endif
        }
    }
}
