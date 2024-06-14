//
//  NetworkError.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case parseError(message: String)
    case unknown(message: String)
}
