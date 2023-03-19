//
//  ContentView.swift
//  Speacher
//
//  Created by Vadim on 9/8/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<FileEntity>
    
    @State private var sideBarState: MenuStates = .Library

    var body: some View {
        NavigationView {
            Sidebar(sideBarState: $sideBarState)
            Main(menuState: $sideBarState)
        }
        .navigationTitle("Library")
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: { }) {
                    Image(systemName: "chevron.left")
                }
                .disabled(true)
            }
                    
            ToolbarItem(placement: .navigation) {
                Button(action: { }) {
                    Image(systemName: "chevron.right")
                }
                .disabled(true)
            }
            
            ToolbarItem(placement: .status) {
                HStack {
                    Text("Jordan Singer")
                    
                    Divider()
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(.secondary)
                }
                .foregroundColor(.secondary)
            }

            ToolbarItem(placement: .status) {
                Button(action: { }) {
                    Image(systemName: "bell")
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = FileEntity(context: viewContext)
            newItem.title = "IT"

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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

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
