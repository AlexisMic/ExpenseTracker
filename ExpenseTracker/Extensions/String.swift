//
//  String.swift
//  ExpenseTracker
//
//  Created by Alexis Schotte on 23/11/2023.
//

import Foundation

extension String {
    
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date() }
        return parsedDate
    }
    
}
