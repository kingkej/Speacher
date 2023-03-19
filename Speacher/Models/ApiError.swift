//
//  ApiError.swift
//  Speacher
//
//  Created by Vadim on 9/11/22.
//

import Foundation

enum ApiErros: Error {
    case invalidUrl(String)
    case failedToGetResponse(String)
}
