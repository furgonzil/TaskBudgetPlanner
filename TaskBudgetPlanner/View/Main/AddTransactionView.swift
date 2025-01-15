//
//   AddTransactionView.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 13.01.25.
//

import SwiftUI
import Combine

struct AddTransactionView: View {
    @StateObject var viewModel = BudgetViewModel()
    @State private var showingAddSheet = false
    @State private var searchText = ""
    
    var filteredTransactions: [Transaction] {
        if searchText.isEmpty {
            return viewModel.transactions
        }
        return viewModel.transactions.filter { transaction in
            transaction.note.localizedCaseInsensitiveContains(searchText) ||
            transaction.category.rawValue.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                // Summary Section
                Section {
                    HStack {
                        StatisticBox(
                            title: "Income",
                            value: viewModel.calculateTotal(for: .income),
                            color: .green,
                            icon: "arrow.down.circle.fill"
                        )
                        
                        StatisticBox(
                            title: "Expenses",
                            value: viewModel.calculateTotal(for: .expense),
                            color: .red,
                            icon: "arrow.up.circle.fill"
                        )
                    }
                }
                
                // Transactions List
                Section("Recent Transactions") {
                    ForEach(filteredTransactions.reversed()) { transaction in
                        TransactionRow(transaction: transaction)
                            .contextMenu {
                                Button(role: .destructive) {
                                    viewModel.removeTransaction(transaction)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                    .onDelete { indexSet in
                        let reversedIndices = indexSet.map { filteredTransactions.count - 1 - $0 }
                        viewModel.removeTransactions(at: IndexSet(reversedIndices))
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search transactions")
            .navigationTitle("Budget")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddSheet) {
            TransactionFormView(viewModel: viewModel)
        }
    }
}
