//
//  BudgetView.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import SwiftUI

struct BudgetView: View {
    @State private var budgetAmount: String = ""

    var body: some View {
        VStack {
            Text("Add Budget")
                .font(.headline)
                .padding()

            TextField("Enter Amount", text: $budgetAmount)
                .inputFieldStyle()
                .onChange(of: budgetAmount) { oldValue, newValue in
                    // Фильтруем только цифры и десятичную точку
                    budgetAmount = newValue.filter { "0123456789.".contains($0) }
                }

            Button(action: {
                // Логика сохранения бюджета
                print("Budget saved: \(budgetAmount)")
            }) {
                Text("Save Budget")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.accentPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
        }
        .padding()
        .frame(width: 600, height: 800)
        .background(AppTheme.backgroundPrimary)
        .cornerRadius(15)
    }
}
