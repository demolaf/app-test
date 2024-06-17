//
//  UserMO.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

extension CurrentUserMO {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        createdAt = Date()
    }

    func toUserEntity() -> CurrentUser {
        CurrentUser(
            userId: userId ?? "",
            name: name ?? "",
            email: email ?? "",
            organization: organization ?? ""
        )
    }
}
