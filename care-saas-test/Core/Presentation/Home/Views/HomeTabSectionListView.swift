//
//  HomeTabSectionListView.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import SwiftUI

struct HomeTabSectionListView: View {
    let tasks: [UserTask]

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(tasks, id: \.taskId) { task in
                    HomeTabSectionListItem(
                        action: task.action,
                        userId: task.userId,
                        timeOfDay: task.timeOfDay,
                        hourOfDay: task.hourOfDay,
                        userName: task.userName ?? "N/A"
                    )
                    .padding(.bottom, 12)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
        }
    }
}
