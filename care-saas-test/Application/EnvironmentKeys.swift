//
//  EnvironmentKeys.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

public enum EnvironmentKeys {
    enum Keys {
        static let baseUrl = "BASE_URL"
    }

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }

        return dict
    }()

    static let baseUrl: String = {
        guard let baseUrlString = EnvironmentKeys.infoDictionary[Keys.baseUrl] as? String else {
            fatalError("BASE_URL not set in plist")
        }

        return baseUrlString
    }()
}
