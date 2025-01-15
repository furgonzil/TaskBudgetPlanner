//
//  StatisticBox.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 14.01.25.
//

import SwiftUI

struct StatisticBox: View {
    let title: String
    let value: Double
    let color: Color
    var subtitle: String? = nil
    var icon: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.headline)
                }
                
                Text(title)
                    .foregroundColor(AppTheme.textSecondary)
                    .font(.subheadline)
            }
            
            Text("$\(value, specifier: "%.2f")")
                .foregroundColor(color)
                .font(.title2)
                .bold()
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}
