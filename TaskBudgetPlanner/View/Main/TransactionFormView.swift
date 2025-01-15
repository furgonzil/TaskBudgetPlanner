//
//  TransactionFormView.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 15.01.25.
//

import SwiftUI

struct TransactionFormView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: BudgetViewModel

    @State private var amount = ""
    @State private var note = ""
    @State private var type: TransactionType = .expense
    @State private var category: TransactionCategory = .other
    @State private var date = Date()
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transaction Details")) {
                    Picker("Type", selection: $type) {
                        Text("Expense").tag(TransactionType.expense)
                        Text("Income").tag(TransactionType.income)
                    }
                    .pickerStyle(.segmented)

                    TextField("Amount", text: $amount)
                        .textFieldStyle(.roundedBorder)

                    TextField("Note", text: $note)
                        .textFieldStyle(.roundedBorder)
                }

                Section(header: Text("Category")) {
                    Picker("Category", selection: $category) {
                        ForEach(TransactionCategory.allCases, id: \.self) { category in
                            Label {
                                Text(category.rawValue)
                            } icon: {
                                Image(systemName: category.icon)
                            }
                            .tag(category)
                        }
                    }
                }

                Section(header: Text("Date")) {
                    DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                }
            }
            .navigationTitle("New Transaction")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addTransaction()
                    }
                }
            }
            .alert("Error", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }

    private func addTransaction() {
        guard let amountValue = Double(amount), amountValue > 0 else {
            alertMessage = "Please enter a valid amount"
            showingAlert = true
            return
        }

        let transaction = Transaction(
            amount: amountValue,
            note: note,
            type: type,
            category: category,
            date: date
        )

        viewModel.addTransaction(transaction)
        dismiss()
    }
}
