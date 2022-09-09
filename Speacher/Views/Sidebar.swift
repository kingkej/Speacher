//
//  Sidebar.swift
//  Speacher
//
//  Created by Vadim on 9/8/22.
//

import Foundation
import SwiftUI

struct Sidebar: View {
    @Binding var sideBarState: MenuStates
    @State var selection: Set<Int> = [0]
    @State private var presentImporter = false
    let networker = Networker()
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        List(selection: self.$selection) {
            Group {
                Button(action:{
                    sideBarState = .Library
                }) {
                    Text("Library")
                        
                }
                .buttonStyle(PlainButtonStyle())  
                
                Button(action:{
                    sideBarState = .Settings
                }) {
                    Text("Settings")
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            Divider()
            
            Group {
                Text("Add files")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                
                Button(action: {
                    presentImporter = true
                }) {
                    Text("Add PDF")
                }
                .fileImporter(isPresented: $presentImporter, allowedContentTypes: [.pdf]) { result in
                            switch result {
                            case .success(let url):
                                if url.startAccessingSecurityScopedResource() {
                                    let docData = try? Data(contentsOf: url)
                                    guard let docData = docData else {
                                        print("Could not receive data from server")
                                        return
                                    }
                                    Task {
                                        await FetchDataAndSave(bytes: docData)
                                    }
                                }
                            case .failure(let error):
                                print(error)
                    }
                }
                
                Text("Add ePub")
            }
        }
       
        .listStyle(SidebarListStyle())
        .frame(minWidth: 192, idealWidth: 192, maxWidth: 256, maxHeight: .infinity)
    }
    
    func FetchDataAndSave(bytes: Data) async {
            do {
                var recognitionResult = try await networker.getPdfData(fileBytes: bytes)
                var file = FileEntity(context: viewContext)
                file.title = recognitionResult.title
                
                var chapter = ChapterEntity(context: viewContext)
                chapter.title = "testy"
                chapter.paragraphs = ["test"]
                
                file.addToChapters(chapter)
                addItem(recognitionResult: recognitionResult)
            } catch {
                print("Error", error)
            }
        }
    
    private func addItem(recognitionResult: TextDetectedResponse) {
        withAnimation {
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
