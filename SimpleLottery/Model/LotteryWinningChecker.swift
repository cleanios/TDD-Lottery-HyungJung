//
//  LotteryWinningChecker.swift
//  SimpleLottery
//
//  Created by HyungJung Kim on 18/03/2019.
//  Copyright © 2019 HyungJung Kim. All rights reserved.
//

import Foundation

struct LotteryWinningChecker {
    
    private let winningNumbers: [Int]
    private let bonusNumber: Int
    
    init(winningNumbers: [Int], bonusNumber: Int) {
        self.winningNumbers = winningNumbers
        self.bonusNumber = bonusNumber
    }
    
    func checkedLottery(for lottery: Lottery) -> LotteryWinningGrade {
        let matchingCount = Set(lottery.numbers).intersection(self.winningNumbers).count
        let hasBonus = lottery.numbers.contains(self.bonusNumber)
        
        return LotteryWinningGradeFactory.winningGrade(for: matchingCount, hasBonus: hasBonus)
    }
    
    func checkedLotteries(for lotteries: [Lottery]) -> [LotteryWinningGrade] {
        return lotteries.map { self.checkedLottery(for: $0) }
    }
    
}
