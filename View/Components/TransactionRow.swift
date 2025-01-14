//
//  TransactionRow.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 14.01.25.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 12) {
            // Category Icon
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
            
            // Transaction Details
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.category.rawValue)
                    .foregroundColor(AppTheme.textPrimary)
                    .font(.subheadline)
                
                if !transaction.note.isEmpty {
                    Text(transaction.note)
                        .font(.caption)
                        .foregroundColor(AppTheme.textSecondary)
                }
                
                Text(formatDate(transaction.date))
                    .font(.caption2)
                    .foregroundColor(AppTheme.textSecondary)
            }
            
            Spacer()
            
            // Amount
            Text(formatAmount(transaction.amount, type: transaction.type))
                .foregroundColor(transaction.type == .income ? .green : .red)
                .font(.system(.body, design: .rounded))
                .bold()
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle()) // Makes the row tappable
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    private func formatAmount(_ amount: Double, type: TransactionType) -> String {
        let prefix = type == .income ? "+" : "-"
        return "\(prefix)$\(String(format: "%.2f", amount))"
    }
}
