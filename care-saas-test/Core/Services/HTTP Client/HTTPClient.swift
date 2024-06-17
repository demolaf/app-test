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
        urlSession: URLSession,
        accessTokenManager: AccessTokenManager
    ) {
        self.urlSession = urlSession
        self.accessTokenManager = accessTokenManager
    }

    let urlSession: URLSession
    let accessTokenManager: AccessTokenManager

    func perform<ResponseType: Decodable>(
        _ request: NetworkRequest
    ) async throws -> ResponseType {
        let accessToken = accessTokenManager.fetchToken()
        let (data, response) = try await urlSession.data(for: request.createURLRequest(accessToken: accessToken))
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            //debugPrint("Error Server Response \(response)")
            debugPrint("Error Server Response \(String(data: data, encoding: .utf8)!)")
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
