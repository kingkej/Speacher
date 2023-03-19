//
//  Sidebar.swift
//  Speacher
//
//  Created by Vadim on 9/8/22.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct Sidebar: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var sideBarState: MenuStates
    
    @State var selection: Set<Int> = [0]
    @State private var showingAlert = false
    @State private var alertTitle = ""
    
    @State private var presentEpubImporter = false
    @State private var presentPdfImporter = false
    @State private var presentDocImporter = false
    @State private var presentFb2Importer = false
    
    let networker = Networker()
    let docType = UTType(tag: "docx", tagClass: .filenameExtension, conformingTo: nil)
    let fb2Type = UTType(tag: "fb2", tagClass: .filenameExtension, conformingTo: nil)
    
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
                    presentPdfImporter = true
                }) {
                    Text("Add PDF")
                }
                .fileImporter(isPresented: $presentPdfImporter, allowedContentTypes: [.pdf]) { result in
                            switch result {
                            case .success(let url):
                                if url.startAccessingSecurityScopedResource() {
                                    let docData = try? Data(contentsOf: url)
                                    guard let docData = docData else {
                                        print("Could not receive data from server")
                                        return
                                    }
                                    Task {
                                        await FetchDataAndSave(bytes: docData, fileType: .pdf)
                                    }
                                }
                            case .failure(let error):
                                print(error)
                    }
                }
                
                Button(action: {
                    presentEpubImporter = true
                }) {
                    Text("Add ePub")
                }
                .fileImporter(isPresented: $presentEpubImporter, allowedContentTypes: [.epub]) { result in
                            switch result {
                            case .success(let url):
                                if url.startAccessingSecurityScopedResource() {
                                    let docData = try? Data(contentsOf: url)
                                    guard let docData = docData else {
                                        print("Could not receive data from server")
                                        return
                                    }
                                    Task {
                                        await FetchDataAndSave(bytes: docData, fileType: .epub)
                                    }
                                }
                            case .failure(let error):
                                print(error)
                    }
                }
                
                Button(action: {
                    presentDocImporter = true
                }) {
                    Text("Add Doc")
                }
                .fileImporter(isPresented: $presentDocImporter, allowedContentTypes: [docType!]) { result in
                            switch result {
                            case .success(let url):
                                if url.startAccessingSecurityScopedResource() {
                                    let docData = try? Data(contentsOf: url)
                                    guard let docData = docData else {
                                        print("Could not receive data from server")
                                        return
                                    }
                                    Task {
                                        await FetchDataAndSave(bytes: docData, fileType: .doc)
                                    }
                                }
                            case .failure(let error):
                                print(error)
                    }
                }
                
                Button(action: {
                    presentFb2Importer = true
                }) {
                    Text("Add FB2")
                }
                .fileImporter(isPresented: $presentFb2Importer, allowedContentTypes: [fb2Type!]) { result in
                            switch result {
                            case .success(let url):
                                if url.startAccessingSecurityScopedResource() {
                                    let docData = try? Data(contentsOf: url)
                                    guard let docData = docData else {
                                        print("Could not receive data from server")
                                        return
                                    }
                                    Task {
                                        await FetchDataAndSave(bytes: docData, fileType: .fb2)
                                    }
                                }
                            case .failure(let error):
                                print(error)
                    }
                }
            }
        }
        .alert("title", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 192, idealWidth: 192, maxWidth: 256, maxHeight: .infinity)
    }
    
    func FetchDataAndSave(bytes: Data, fileType: DocymentTypes) async {
            do {
                let recognitionResult = try await networker.getDocumentData(documentBytes: bytes, documentType: fileType)
                
                guard let recognitionResult = recognitionResult.textDetectedResponse else {
                    alertTitle = "Unable to open the file"
                    showingAlert = true
                    return
                }

                let file = FileEntity(context: viewContext)
                file.title = recognitionResult.title
                file.titleImage = recognitionResult.titleImage
                file.paragraphs = recognitionResult.paragraphs
                file.language = recognitionResult.language
                file.readingTime = Int64(recognitionResult.readingTime)
                
                var chaptersSet: Set<ChapterEntity> = []
                var counter: Int16 = 0
                recognitionResult.chapters?.forEach({ chapter in
                    let chapterEntity = ChapterEntity(context: viewContext)
                    chapterEntity.ObjectId = counter
                    chapterEntity.title = chapter.title
                    chapterEntity.paragraphs = chapter.paragraphs
                    chaptersSet.insert(chapterEntity)
                })
                print()
                file.chapters = chaptersSet
                try viewContext.save()
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

