//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Alexis Schotte on 23/11/2023.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    //MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    //MARK: Chart
                    let data = transactionListVM.accumulateTransactions()
                    if !data.isEmpty {
                        let totalExpenses = data.last?.1 ?? 0
                        CardView {
                            VStack(alignment: .leading) {
                                ChartLabel(totalExpenses.formatted(.currency(code: "USD")), type: .title, format: "US$%0.2f")
                                LineChart()
                            }
                            .background(Color(uiColor: .systemBackground))
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color(uiColor: .systemBackground), foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                        .frame(height: 300)
                    } else {
                        ProgressView()
                    }
                    

                    //MARK: Recent transactions
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
//            .navigationTitle("Overview")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
            }
        }
        .accentColor(.primary)
    }
}

#Preview {
    ContentView()
        .environmentObject(TransactionListViewModel())
}
