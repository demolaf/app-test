//
//  UserMO.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

extension UserMO {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        createdAt = Date()
    }

    func toUserEntity() -> User {
        User(
            userId: userId ?? "",
            name: name ?? "",
            email: email ?? "",
            organization: organization ?? ""
        )
    }
}
