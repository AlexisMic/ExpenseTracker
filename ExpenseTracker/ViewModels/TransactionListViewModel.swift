//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Alexis Schotte on 23/11/2023.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

@MainActor
final class TransactionListViewModel: ObservableObject {
    
    @Published var transactions: [Transaction] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
//        Task {
//            do {
//                try await getTransactionsAsync()
//            } catch {
//                print("error do catch")
//            }
//        }
        getTransactions()
    }
    
    func getTransactions() {
        
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpURLresponse = response as? HTTPURLResponse, httpURLresponse.statusCode == 200 else {
                    print("Bad response")
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("failure")
                    print(error.localizedDescription)
                case .finished:
                    print("finished")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
            }
            .store(in: &cancellables)

    }
    
    func getTransactionsAsync() async throws {
        
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let safeResponse = response as? HTTPURLResponse else {
            print("Bad response")
            return
        }
        
        guard safeResponse.statusCode == 200 else {
            print("Bad status code")
            return
        }
        self.transactions = try JSONDecoder().decode([Transaction].self, from: data)
    }
    
    func groupTransactionsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:]}
        return TransactionGroup(grouping: transactions, by: {$0.month})
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        guard !transactions.isEmpty else { return []}
        
        let today = "02/17/2022".dateParsed() //Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter({ $0.dateParsed == date && $0.isExpense })
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            cumulativeSum.append((date.formatted(), sum))
        }
        
        return cumulativeSum
    }
    
}
