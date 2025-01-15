//
//  BudgetViewModel.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import SwiftUI

class BudgetViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var monthlyBudget: Double = 0.0
    
    private let userDefaults = UserDefaults.standard
    private let transactionsKey = "transactions"
    private let monthlyBudgetKey = "monthlyBudget"
    
    init() {
        loadData()
    }
    
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        saveData()
    }
    
    func removeTransaction(_ transaction: Transaction) {
        transactions.removeAll { $0.id == transaction.id }
        saveData()
    }
    
    func removeTransactions(at indexSet: IndexSet) {
        transactions.remove(atOffsets: indexSet)
        saveData()
    }
    
    func calculateTotal(for type: TransactionType) -> Double {
        transactions
            .filter { $0.type == type && Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .month) }
            .reduce(0) { $0 + $1.amount }
    }
    
    func calculateBalance() -> Double {
        calculateTotal(for: .income) - calculateTotal(for: .expense)
    }
    
    func transactionsForPeriod(_ period: DateComponents) -> [Transaction] {
        transactions.filter { transaction in
            Calendar.current.isDate(transaction.date, equalTo: period.date ?? Date(), toGranularity: .month)
        }
    }
    
    func totalsByCategory(type: TransactionType) -> [(TransactionCategory, Double)] {
        let currentMonthTransactions = transactions.filter {
            Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .month) && $0.type == type
        }
        
        return Dictionary(grouping: currentMonthTransactions) { $0.category }
            .mapValues { transactions in
                transactions.reduce(0) { $0 + $1.amount }
            }
            .map { ($0.key, $0.value) }
            .sorted { $0.1 > $1.1 }
    }
    
    func setMonthlyBudget(_ amount: Double) {
        monthlyBudget = amount
        userDefaults.set(amount, forKey: monthlyBudgetKey)
    }
    
    func getBudgetProgress() -> Double {
        guard monthlyBudget > 0 else { return 0 }
        return calculateTotal(for: .expense) / monthlyBudget
    }
    
    private func loadData() {
        if let data = userDefaults.data(forKey: transactionsKey),
           let decoded = try? JSONDecoder().decode([Transaction].self, from: data) {
            transactions = decoded
        }
        
        monthlyBudget = userDefaults.double(forKey: monthlyBudgetKey)
    }
    
    private func saveData() {
        if let encoded = try? JSONEncoder().encode(transactions) {
            userDefaults.set(encoded, forKey: transactionsKey)
        }
    }
}
