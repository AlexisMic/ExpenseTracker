//
//  RecentTransactionList.swift
//  ExpenseTracker
//
//  Created by Alexis Schotte on 24/11/2023.
//

import SwiftUI

struct RecentTransactionList: View {
    
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Recent transactions")
                    .bold()
                Spacer()
                NavigationLink {
                    TransactionListView()
                } label: {
                    HStack(spacing: 4) {
                        Text("See all")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(Color.text)
                }

            }
            .padding(.top)
            
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()), id: \.element) { index, transaction in
                TransactionRow(transaction: transaction)
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
        }
        .padding()
        .background(Color(uiColor: UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0.0, y: 5)
//        .task {
//            do {
//                try await transactionListVM.getTransactionsAsync()
//            } catch {
//                print("error do catch")
//            }
//        }
    }
}

#Preview {
    RecentTransactionList()
        .environmentObject(TransactionListViewModel())
}
