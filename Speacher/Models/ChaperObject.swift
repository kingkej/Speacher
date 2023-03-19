//
//  ChaperObject.swift
//  Speacher
//
//  Created by Vadim on 9/9/22.
//

import Foundation

public class ChapterObject: NSObject {
    let title: String?
    let paragraphs: [String]
    
    init(title: String?, paragraphs: [String]) {
        self.title = title
        self.paragraphs = paragraphs
    }
}
