//
//  HTTPClient.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

protocol HTTPClient {
    func perform<ResponseType: Decodable>(
        _ request: NetworkRequest
    ) async throws -> ResponseType
}

class HTTPClientImpl: HTTPClient {
    init(
        urlSession: URLSession
    ) {
        self.urlSession = urlSession
    }

    let urlSession: URLSession

    func perform<ResponseType: Decodable>(
        _ request: NetworkRequest
    ) async throws -> ResponseType {
        let (data, response) = try await urlSession.data(for: request.createURLRequest())
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            debugPrint("Error Server Response \(response)")
            throw NetworkError.invalidServerResponse
        }

        do {
            debugPrint("Response Data: \(String(data: data, encoding: .utf8)!)")
            let jsonDecoder: JSONDecoder = JSONDecoder()
            //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try jsonDecoder.decode(ResponseType.self, from: data)
            debugPrint("Response Parsed: \(response)")
            return response
        } catch {
            debugPrint("Response error \(error)")
            throw NetworkError.parseError(message: error.localizedDescription)
        }
    }
}
