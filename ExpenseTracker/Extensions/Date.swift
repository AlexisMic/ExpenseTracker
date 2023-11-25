//
//  Date.swift
//  ExpenseTracker
//
//  Created by Alexis Schotte on 23/11/2023.
//

import Foundation

extension DateFormatter {
    
    static var allNumericUSA: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
}

extension Date {
    
    func formatted() -> String {
        self.formatted(.dateTime.year().month().day())
    }
}
