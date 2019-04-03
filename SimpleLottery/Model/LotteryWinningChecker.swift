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
        let numberOfMatching = lottery.numbers.filter { self.winningNumbers.contains($0) }.count
        let hasBonus = !(lottery.numbers.filter { $0 == self.bonusNumber }.isEmpty)
        
        return LotteryWinningGradeFactory.lotteryWinningGrade(numberOfMatching: numberOfMatching, hasBonus: hasBonus)
    }
    
    func checkedLotteries(for lotteries: [Lottery]) -> [LotteryWinningGrade] {
        return lotteries.map { self.checkedLottery(for: $0) }
    }
    
}
