//
//  Lottery.swift
//  SimpleLottery
//
//  Created by HyungJung Kim on 18/03/2019.
//  Copyright © 2019 HyungJung Kim. All rights reserved.
//

import Foundation

struct Lottery {
    
    static let price = 1000
    static let numbersRange = 1...45
    static let numbersMaximumCount = 6
    
    let numbers: [Int]
    
    init(numbers: [Int] = []) {
        self.numbers = Lottery.generatedNumbers(with: numbers)
    }
    
    private static func generatedNumbers(with numbers: [Int]) -> [Int] {
        var nonredundantNumbers = Set(numbers)
        
        if nonredundantNumbers.count > self.numbersMaximumCount {
            nonredundantNumbers = Set(nonredundantNumbers.prefix(self.numbersMaximumCount))
        }
        
        while nonredundantNumbers.count < self.numbersMaximumCount {
            nonredundantNumbers.insert(Int.random(in: self.numbersRange))
        }
        
        return Array(nonredundantNumbers).sorted()
    }
    
}
