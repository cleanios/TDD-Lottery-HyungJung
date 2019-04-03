//
//  SimpleLotteryTests.swift
//  SimpleLotteryTests
//
//  Created by HyungJung Kim on 18/03/2019.
//  Copyright © 2019 HyungJung Kim. All rights reserved.
//

import XCTest
@testable import SimpleLottery

class SimpleLotteryTests: XCTestCase {
    
    func testGenerateNumbers() {
        // given
        
        // when
        let lottery = Lottery()
        
        // then
        XCTAssertEqual(lottery.numbers.count, Lottery.numbersMaximumCount)
        lottery.numbers.forEach { XCTAssertTrue(Lottery.numbersRange.contains($0)) }
    }
    
    func testPurchaseLotteries() {
        // given
        let purchaseAmount = 5000
        let purchaser = LotteryPurchaser()
        let purchasableCount = purchaseAmount / Lottery.price
        
        // when
        purchaser.purchase(for: purchaseAmount)
        
        // then
        XCTAssertEqual(purchaser.lotteries.count, purchasableCount)
    }
    
    func testCheckWinningLotteries() {
        // given
        let lotteries = [Lottery(numbers: [1, 5, 11, 19, 25, 31]),
                         Lottery(numbers: [1, 5, 7, 11, 19, 25]),
                         Lottery(numbers: [1, 5, 11, 19, 25, 45]),
                         Lottery(numbers: [1, 5, 11, 19, 44, 45]),
                         Lottery(numbers: [1, 5, 11, 43, 44, 45]),
                         Lottery(numbers: [1, 5, 42, 43, 44, 45])]
        let winningChecker = LotteryWinningChecker(winningNumbers: [1, 5, 11, 19, 25, 31], bonusNumber: 7)
        let rankings = [1, 2, 3, 4, 5, 6]
        let prizes = [2000000000, 30000000, 1500000, 50000, 5000, 0]
        
        // when
        let checkedLotteries = lotteries.map { winningChecker.checkedLottery(for: $0) }
        
        // then
        checkedLotteries.enumerated().forEach { (index, checkedLottery) in
            XCTAssertEqual(checkedLottery.ranking, rankings[index])
            XCTAssertEqual(checkedLottery.prize, prizes[index])
        }
    }
    
}
