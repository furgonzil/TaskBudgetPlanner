//
//  Transaction.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import Foundation

struct Transaction: Identifiable, Codable {
    let id: UUID
    var amount: Double
    var note: String
    var type: TransactionType
    var category: TransactionCategory
    var date: Date  // Added this line

    init(amount: Double, note: String, type: TransactionType, category: TransactionCategory, date: Date) {
        self.id = UUID()
        self.amount = amount
        self.note = note
        self.type = type
        self.category = category
        self.date = date
    }
}
