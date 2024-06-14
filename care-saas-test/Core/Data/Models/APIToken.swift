//
//  APIToken.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

struct APIToken {
  let tokenType: String
  let expiresIn: Int
  let accessToken: String
  let refreshToken: String
  private let requestedAt = Date()
}

// MARK: - Helper properties
extension APIToken {
  var expiresAt: Date {
    Calendar.current.date(byAdding: .second, value: expiresIn, to: requestedAt) ?? Date()
  }

  var bearerAccessToken: String {
    "\(tokenType) \(accessToken)"
  }
}
