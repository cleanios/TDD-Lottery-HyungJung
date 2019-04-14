//
//  LotteryWinningChecker.swift
//  SimpleLottery
//
//  Created by HyungJung Kim on 18/03/2019.
//  Copyright © 2019 HyungJung Kim. All rights reserved.
//

import Foundation
import os.log

struct LotteryWinningChecker {
    
    private(set) var winningNumbers: [Int]
    private(set) var bonusNumber: Int
    
    init() {
        self.winningNumbers = Lottery().numbers
        self.bonusNumber = winningNumbers.prefix(1).compactMap { $0 }.reduce(0, +)
        
        while self.winningNumbers.contains(self.bonusNumber) {
            self.bonusNumber = Int.random(in: 1...45)
        }
        
        os_log("Winning numbers are %s.", log: .default, type: .info, self.winningNumbers.description)
        os_log("Bonus number is %d.", log: .default, type: .info, self.bonusNumber)
    }
    
    func checkedLottery(for lottery: Lottery) -> LotteryWinningGrade {
        let matching = Set(lottery.numbers).intersection(self.winningNumbers).count
        let hasBonus = lottery.numbers.contains(self.bonusNumber)
        
        return LotteryWinningGradeFactory.makeWinningGrade(matching: matching, hasBonus: hasBonus)
    }
    
    func checkedLotteries(for lotteries: [Lottery]) -> [LotteryWinningGrade] {
        return lotteries.map { self.checkedLottery(for: $0) }
    }
    
}
