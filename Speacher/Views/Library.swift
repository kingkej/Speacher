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
                        
                        //LazyVGrid(columns: columns, spacing: 20) {
                         
                        //}
                        
                    }
                    .padding()
                    Spacer()
                }
            }
            .padding(.bottom, 64)
            .background(Color(NSColor.controlBackgroundColor))
            
        }
        .frame(minWidth: 880, maxHeight: .infinity)
    }
}
