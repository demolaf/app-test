//
//  AllUserTasksResponse.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
//

import Foundation

struct AllUserTasksResponse: Codable {
    let status: String
    let code: Int
    let message: String
    let data: [AllUserTasks]
}

struct AllUserTasks: Codable {
    let taskId, taskType, timeOfDay, taskGroup: String
    let action, order: String
    let taskDetailRef: String
    let hourOfDay: String?
    let supportLevel: String?
    let taskDate: String
    let isAssigned: Bool
    let userId: Int
    let taskScheduleId: String
    let taskAssignments: [TaskAssignment]?

    enum CodingKeys: String, CodingKey {
        case taskId = "taskId"
        case hourOfDay
        case taskType, timeOfDay, taskGroup, action, order, taskDetailRef, supportLevel, taskDate, isAssigned
        case userId = "userId"
        case taskScheduleId = "taskScheduleId"
        case taskAssignments
    }
}

struct TaskAssignment: Codable {
    let assignee: Assignee
}

struct Assignee: Codable {
    let userId: Int
    let firstName, lastName: String

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case firstName, lastName
    }
}

extension AllUserTasks {
    func toTaskEntity() -> UserTask {
        UserTask(
            taskId: taskId,
            userId: userId,
            action: action.capitalized,
            timeOfDay: timeOfDay,
            hourOfDay: hourOfDay ?? "Unknown",
            userName: nil
        )
    }
}
