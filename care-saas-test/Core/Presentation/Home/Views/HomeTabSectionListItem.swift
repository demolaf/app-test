//
//  HomeTabSectionListItem.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 17/06/2024.
//

import SwiftUI

struct HomeTabSectionListItem: View {
    let action: String
    let userId: Int
    let timeOfDay: String
    let hourOfDay: String
    let userName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(action)
                Spacer()
                Image(systemName: "arrow.up.right.circle")
            }
            HStack {
                Image(systemName: "person")
                Text(String(userName))
            }
            HStack {
                HStack(spacing: 16) {
                    HStack {
                        Image(systemName: "door.right.hand.open")
                        Text("Room")
                    }
                    HStack {
                        Image(systemName: "bed.double")
                        Text("Bed 45")
                    }
                }
                Spacer()
                HStack {
                    Image(systemName: "clock")
                    Text(hourOfDay)
                }
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.homeListTile)
        }
    }
}
