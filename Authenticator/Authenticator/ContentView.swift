//
//  ContentView.swift
//  Authenticator
//
//  Created by YUKITO on 2022/02/17.
//

import SwiftUI
import CoreData
import SwiftBase32
import CryptoSwift

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.id, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State
    var timeLeft: Int = 30
    
    private var placeHolder: [String] = ["・","・","・","・","・","・"]
    
    @State
    var showAddSheet: Bool = false
    
    @State
    var willEdit: Bool = false
    
    @State
    var copied: Bool = false
    
    @State
    var editViewPresented: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Color(uiColor: .background).edgesIgnoringSafeArea(.all)
                    ScrollView {
                        VStack {
                            ForEach(items, id: \.self) { item in
                                if willEdit {
                                    NavigationLink(isActive: $editViewPresented) {
                                        EditAccountView(CodeItem(id: Int(item.id), key: item.key!, title: item.title!, desc: item.desc ?? ""), isPresented: $editViewPresented)
                                    } label: {
                                        VStack {
                                            Spacer()
                                                .frame(height: 20)
                                            CodeViewPlaceholder(timeLeft: $timeLeft, item: item)
                                                .frame(width: abs(geo.size.width), height: 140)
                                        }
                                    }
                                } else {
                                    Button {
                                        withAnimation {
                                            copied.toggle()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                copied.toggle()
                                            }
                                        }
                                        UIPasteboard.general.string = item.key!.generateCode()
                                    } label: {
                                        VStack {
                                            Spacer()
                                                .frame(height: 20)
                                            CodeView(timeLeft: $timeLeft, item: item)
                                                .frame(width: abs(geo.size.width), height: 140)
                                        }
                                    }
                                }
                            }
                            .transition(
                                AnyTransition.asymmetric(
                                    insertion: AnyTransition.slide.combined(with: AnyTransition.opacity),
                                    removal: AnyTransition.identity
                            ))
                        }
                        .onReceive(timer) { _ in
                            timeLeft = generateLastTime()
                        }
                    }
                    if copied {
                        VStack {
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .frame(width: abs(geo.size.width - 40), height: 50, alignment: .center)
                                    .foregroundColor(Color(uiColor: .systemBackground))
                                    .shadow(color: Color(uiColor: .shadowColor), radius: 10, x: 3, y: 3)
                                HStack {
                                    Spacer().frame(width: 40)
                                    Text("Copied!")
                                        .font(.custom("AvenirNext-DemiBold", size: 16, relativeTo: .headline))
                                    Spacer()
                                }
                            }
                            Spacer().frame(height: 50)
                        }.transition(.opacity)
                    }
                }
            }
            .navigationTitle("Authenticator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .destructive, action: { }) {
                        Label("Remove", systemImage: "line.3.horizontal")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if willEdit {
                        Button(role: .none, action: { willEdit.toggle() }) {
                            Text("Done")
                        }
                    } else {
                        Menu {
                            Button(role: .none, action: { willEdit.toggle() }) {
                                Label("Edit", systemImage: "pencil")
                            }
                            Button(role: .none, action: { showAddSheet.toggle() }) {
                                Label("Add account", systemImage: "plus")
                            }
                        } label: {
                            Label("", systemImage: "ellipsis")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddAccountView(isPresent: $showAddSheet)
        }
    }
    
    func generateLastTime() -> Int {
        let date = Date.now
        let unixTime: TimeInterval = date.timeIntervalSince1970
        let unixTimeInt = Int(unixTime)
        return (30 - unixTimeInt % 30)
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
