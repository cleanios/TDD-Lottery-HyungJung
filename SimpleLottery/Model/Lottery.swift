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
    static let numbersRange = Range(1 ... 45)
    static let numbersMaximumCount = 6
    
    let numbers: [Int]
    
    init() {
        self.numbers = Lottery.generatedNumbers()
    }
    
    init(numbers: [Int]) {
        self.numbers = numbers
    }
    
    private static func generatedNumbers() -> [Int] {
        var numbers: Set<Int> = []
        
        while numbers.count < self.numbersMaximumCount {
            let number = Int.random(in: self.numbersRange)
            
            numbers.insert(number)
        }
        
        return Array(numbers).sorted()
    }
    
}
