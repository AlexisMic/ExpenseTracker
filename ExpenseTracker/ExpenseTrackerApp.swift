//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Alexis Schotte on 23/11/2023.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    
    @StateObject var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
