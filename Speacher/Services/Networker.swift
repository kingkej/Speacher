//
//  Networker.swift
//  Speacher
//
//  Created by Vadim on 9/8/22.
//

import Foundation

struct Networker {
    let endpoint = "http://localhost:5000/api/"
    func getPdfData(fileBytes: Data) async throws -> TextDetectedResponse {
            var url = URL(string: "\(endpoint)Documents/pdf")
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = fileBytes
            urlRequest.addValue("06328b97-f70d-4554-aa92-22cecfb2a0a0", forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/pdf", forHTTPHeaderField: "Content-Type")
              let (data, response) = try await URLSession.shared.data(for: urlRequest)

              guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
              let recognitionResult = try JSONDecoder().decode(TextDetectedResponse.self, from: data)
            return recognitionResult
    }
    
    func getDocumentData(documentBytes: Data, documentType: DocymentTypes) async throws -> ( textDetectedResponse: TextDetectedResponse?, error: Error?) {
        let url = URL(string: "\(endpoint)Documents/\(documentType.rawValue)")
        guard let url = url else {
            return (nil, ApiErros.invalidUrl("Invalid URL was provided"))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = documentBytes
        urlRequest.addValue("06328b97-f70d-4554-aa92-22cecfb2a0a0", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/\(documentType.rawValue)", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            return (nil, ApiErros.failedToGetResponse("Status code not 200"))
        }
        let recognitionResult = try JSONDecoder().decode(TextDetectedResponse.self, from: data)
        
        return (recognitionResult, nil)
    }
}
