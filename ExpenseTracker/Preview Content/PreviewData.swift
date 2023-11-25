//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Alexis Schotte on 23/11/2023.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "11/23/2023", institution: "Desjardins", account: "Visa Desjardins", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 001, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
