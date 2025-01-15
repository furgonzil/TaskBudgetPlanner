//
//  TransactionRow.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 14.01.25.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    @AppStorage("showDecimals") private var showDecimals = true
    @AppStorage("defaultCurrency") private var defaultCurrency = "USD"
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(transaction.type == .income ?
                          Color.green.opacity(0.1) :
                          Color.red.opacity(0.1))
                    .frame(width: 40, height: 40)
                
                Image(systemName: transaction.category.icon)
                    .foregroundColor(transaction.type == .income ?
                                   .green : .red)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.category.rawValue)
                    .font(.headline)
                
                if !transaction.note.isEmpty {
                    Text(transaction.note)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Text(formatDate(transaction.date))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(formatAmount(transaction.amount))
                .font(.system(.body, design: .rounded))
                .bold()
                .foregroundColor(transaction.type == .income ? .green : .red)
        }
        .padding(.vertical, 4)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    private func formatAmount(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = defaultCurrency
        formatter.maximumFractionDigits = showDecimals ? 2 : 0
        
        let prefix = transaction.type == .income ? "+" : "-"
        return prefix + (formatter.string(from: NSNumber(value: amount)) ?? "")
    }
}
