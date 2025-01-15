//
//  Task.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var category: TaskCategory
    var dueDate: Date
    var isCompleted: Bool
    var priority: TaskPriority
    var createdAt: Date

    init(title: String, description: String, category: TaskCategory, dueDate: Date, isCompleted: Bool = false, priority: TaskPriority, createdAt: Date = Date()) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.category = category
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.priority = priority
        self.createdAt = createdAt
    }

    static func preview() -> Task {
        Task(
            title: "Sample Task",
            description: "This is a sample task",
            category: .personal,
            dueDate: Date().addingTimeInterval(86400),
            priority: .medium
        )
    }
}

