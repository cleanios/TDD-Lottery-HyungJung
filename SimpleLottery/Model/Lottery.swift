//
//  Lottery.swift
//  SimpleLottery
//
//  Created by HyungJung Kim on 18/03/2019.
//  Copyright © 2019 HyungJung Kim. All rights reserved.
//

import Foundation


struct Lottery {
    
    // MARK - init
    
    init(numbers: [Int] = []) {
        self.numbers = Lottery.generatedNumbers(with: numbers)
    }
    
    // MARK: - internal
    
    static let price = 1000
    static let numberRange = 1...45
    static let numbersCount = 6
    
    let numbers: [Int]
    
    // MARK: - private
    
    private static func generatedNumbers(with numbers: [Int]) -> [Int] {
        var uniqueNumbers = Set(numbers)
        
        if uniqueNumbers.count > self.numbersCount {
            uniqueNumbers = Set(uniqueNumbers.prefix(self.numbersCount))
        }
        
        while uniqueNumbers.count < self.numbersCount {
            uniqueNumbers.insert(Int.random(in: self.numberRange))
        }
        
        return Array(uniqueNumbers).sorted()
    }
    
}
