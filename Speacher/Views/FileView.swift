//
//  FileView.swift
//  Speacher
//
//  Created by Vadim on 9/9/22.
//

import SwiftUI

struct FileView: View {
    var isParagraphs: Bool {
        if file.paragraphs != nil {
            return true
        }
        return false
    }
    
    let file: FileEntity
    
    var body: some View {
        Text(file.title ?? "Unknown title")
        ScrollView {
            if !isParagraphs {
                ForEach(file.chaptersT, id: \.self) { chapter in
                    Text(chapter.title ?? "Unknown title")
                        .bold()
                        .font(.title)
                    ForEach(chapter.paragraphs!, id: \.self) { paragraph in
                      Text(paragraph)
                    }
                }
            }
            else if isParagraphs {
                ForEach(file.paragraphs!, id: \.self) {  paragraph in
                    Text(paragraph)
                }
            }
        }
    }
}

