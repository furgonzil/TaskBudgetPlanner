//
//  BudgetViewModel.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import SwiftUI

class BudgetViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    private let userDefaults = UserDefaults.standard
    
    init() {
        loadTransactions()
    }
    
    func addTransaction(_ transaction: Transaction) {
        withAnimation {
            transactions.append(transaction)
            saveTransactions()
        }
    }
    
    func calculateTotal(for type: TransactionType) -> Double {
        transactions.filter { $0.type == type }.reduce(0) { $0 + $1.amount }
    }
    
    func totalsByCategory(type: TransactionType) -> [(TransactionCategory, Double)] {
        Dictionary(grouping: transactions.filter { $0.type == type }) { $0.category }
            .mapValues { transactions in
                transactions.reduce(0) { $0 + $1.amount }
            }
            .map { ($0.key, $0.value) }
            .sorted { $0.1 > $1.1 }
    }
    
    private func saveTransactions() {
        if let encoded = try? JSONEncoder().encode(transactions) {
            userDefaults.set(encoded, forKey: "transactions")
        }
    }
    
    private func loadTransactions() {
        if let data = userDefaults.data(forKey: "transactions"),
           let decoded = try? JSONDecoder().decode([Transaction].self, from: data) {
            transactions = decoded
        }
    }
}
