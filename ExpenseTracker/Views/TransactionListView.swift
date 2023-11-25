//
//  TransactionListView.swift
//  ExpenseTracker
//
//  Created by Alexis Schotte on 23/11/2023.
//

import SwiftUI

struct TransactionListView: View {
    
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(Array(transactionListVM.groupTransactionsByMonth()), id: \.key) { month, transactions in
                        Section {
                            ForEach(transactions) { transaction in
                                TransactionRow(transaction: transaction)
                            }
                        } header: {
                            Text(month)
                        }
                        .listSectionSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TransactionListView()
        .environmentObject(TransactionListViewModel())
}
