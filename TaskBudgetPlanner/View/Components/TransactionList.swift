//
//  TransactionList.swift
//  TaskBudgetPlanner
//
//  Created by Ваня Фурса on 15.01.25.
//

import SwiftUI

struct TransactionList: View {
    @ObservedObject var viewModel: BudgetViewModel


    @State private var sortOrder = SortOrder.dateDescending
    @State private var categoryFilter: TransactionCategory?
    @State private var dateFilter = DateFilter.all
    @State private var searchText = ""
    
    enum SortOrder: String, CaseIterable {
        case dateDescending = "Latest First"
        case dateAscending = "Oldest First"
        case amountDescending = "Highest Amount"
        case amountAscending = "Lowest Amount"
    }
    
    enum DateFilter: String, CaseIterable {
        case all = "All Time"
        case today = "Today"
        case thisWeek = "This Week"
        case thisMonth = "This Month"
        case thisYear = "This Year"
    }
    
    var filteredAndSortedTransactions: [Transaction] {
        var result = viewModel.transactions
        
        // Apply category filter
        if let category = categoryFilter {
            result = result.filter { $0.category == category }
        }
        
        // Apply date filter
        result = result.filter { transaction in
            switch dateFilter {
            case .all:
                return true
            case .today:
                return Calendar.current.isDateInToday(transaction.date)
            case .thisWeek:
                return Calendar.current.isDate(transaction.date, equalTo: Date(), toGranularity: .weekOfYear)
            case .thisMonth:
                return Calendar.current.isDate(transaction.date, equalTo: Date(), toGranularity: .month)
            case .thisYear:
                return Calendar.current.isDate(transaction.date, equalTo: Date(), toGranularity: .year)
            }
        }
        
        // Apply search filter
        if !searchText.isEmpty {
            result = result.filter { transaction in
                transaction.note.localizedCaseInsensitiveContains(searchText) ||
                transaction.category.rawValue.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Apply sort
        result.sort { first, second in
            switch sortOrder {
            case .dateDescending:
                return first.date > second.date
            case .dateAscending:
                return first.date < second.date
            case .amountDescending:
                return first.amount > second.amount
            case .amountAscending:
                return first.amount < second.amount
            }
        }
        
        return result
    }
    
    var body: some View {
        List {
            Section {
                HStack {
                    Picker("Sort", selection: $sortOrder) {
                        ForEach(SortOrder.allCases, id: \.self) { order in
                            Text(order.rawValue).tag(order)
                        }
                    }
                    
                    Divider()
                    
                    Menu {
                        ForEach(TransactionCategory.allCases, id: \.self) { category in
                            Button {
                                categoryFilter = category
                            } label: {
                                Label(category.rawValue, systemImage: category.icon)
                            }
                        }
                        
                        Divider()
                        
                        Button("Clear Filter") {
                            categoryFilter = nil
                        }
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
                .padding(.vertical, 8)
            }
            
            Section {
                ForEach(filteredAndSortedTransactions) { transaction in
                    TransactionRow(transaction: transaction)
                        .contextMenu {
                            Button(role: .destructive) {
                                viewModel.removeTransaction(transaction)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search transactions")
    }
}
