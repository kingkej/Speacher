//
//  Library.swift
//  Speacher
//
//  Created by Vadim on 9/8/22.
//

import Foundation
import SwiftUI

struct Library: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<FileEntity>
    
    @Binding var menuState: MenuStates
    @Binding var selectedFile: FileEntity?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                HStack {
                    Spacer()
                    GeometryReader { geo in
                        VStack {
                            HStack {
                                Text("Library")
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                                
                                Image(systemName: "chevron.down")
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                                
                                Spacer()
                            }
                                ForEach(items, id: \.self) { item in
                                    ZStack(alignment: .topTrailing) {
                                        Button(action: {
                                            selectedFile = item
                                            menuState = .OpenFile
                                        }) {
                                            GetImage(file: item)
                                                
                                        }
                                       
                                        
                                        Image(systemName: "x.circle.fill")
                                            .foregroundColor(.red)
                                            .font(.body)
                                            .onTapGesture {
                                                deleteFile(file: item)
                                            }
                                    }
                                }
                            
                        }
                        .padding()
                    }
                    Spacer()
                }
            }
            .padding(.bottom, 64)
            .background(Color(NSColor.controlBackgroundColor))
            
        }
        .frame(minWidth: 880, maxHeight: .infinity)
    }
    
    private func GetImage(file: FileEntity) -> Image {
        if file.titleImage != nil {
            return Image(uiImage: .init(data: file.titleImage!) ?? .init(named: "nava")!)
        }
        return Image(uiImage: .init(named: "nava")!)
    }
    
    private func deleteFile(file: FileEntity){
        viewContext.delete(file)
        do{
            try viewContext.save()
        }catch{
            print(error)
        }
    }
}

