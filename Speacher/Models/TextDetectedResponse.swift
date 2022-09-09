//
//  TextDetectedResponse.swift
//  Speacher
//
//  Created by Vadim on 9/8/22.
//

import Foundation

struct TextDetectedResponse: Identifiable, Decodable {
    var id = UUID()
    var title: String?
    var language: String?
    var titleImage: Data?
    let paragraphs: [String]?
    let chapters: [Chapter]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case language
        case titleImage
        case paragraphs
        case chapters
    }
    
}

struct Chapter: Codable {
    let title: String?
    let paragraphs: [String]
}



