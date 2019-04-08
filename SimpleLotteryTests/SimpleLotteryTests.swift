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
    
    let winningNumbers = [1, 5, 11, 19, 25, 31]
    let bonusNumber = 7
    
    func testGeneratedNumbers() {
        // given
        
        // when
        let lottery = Lottery()
        
        // then
        XCTAssertEqual(lottery.numbers.count, Lottery.numbersMaximumCount)
        lottery.numbers.forEach { XCTAssertTrue(Lottery.numbersRange.contains($0)) }
    }
    
    func testGeneratedNumbers_WhenNumbersMaximumCountIsExceeded() {
        // given
        var nonredundantNumbers: Set<Int> = []
        
        while nonredundantNumbers.count < Lottery.numbersMaximumCount + 1 {
            nonredundantNumbers.insert(Int.random(in: Lottery.numbersRange))
        }
        
        // when
        let lottery = Lottery(numbers: Array(nonredundantNumbers).sorted())
        
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
    
    func testCheckFirstWinning() {
        // given
        let winningChecker = LotteryWinningChecker(winningNumbers: self.winningNumbers, bonusNumber: self.bonusNumber)
        let lottery = Lottery(numbers: self.winningNumbers)
        let expectedRanking = 1
        let expectedPrize = 2_000_000_000
        
        // when
        let checkedLottery = winningChecker.checkedLottery(for: lottery)
        
        // then
        XCTAssertEqual(checkedLottery.ranking, expectedRanking)
        XCTAssertEqual(checkedLottery.prize, expectedPrize)
    }
    
    func testCheckSecondWinning() {
        // given
        let winningChecker = LotteryWinningChecker(winningNumbers: self.winningNumbers, bonusNumber: self.bonusNumber)
        let matchingCount = 5
        var numbers = self.winningNumbers.shuffled().enumerated().compactMap { $0 < matchingCount ? $1 : nil }
        numbers.append(self.bonusNumber)
        let lottery = Lottery(numbers: numbers)
        let expectedRanking = 2
        let expectedPrize = 30_000_000
        
        // when
        let checkedLottery = winningChecker.checkedLottery(for: lottery)
        
        // then
        XCTAssertEqual(checkedLottery.ranking, expectedRanking)
        XCTAssertEqual(checkedLottery.prize, expectedPrize)
    }
    
    func testCheckThirdWinning() {
        // given
        let winningChecker = LotteryWinningChecker(winningNumbers: self.winningNumbers, bonusNumber: self.bonusNumber)
        let matchingCount = 5
        var lottery = Lottery(numbers: [self.bonusNumber])
        
        while lottery.numbers.contains(self.bonusNumber) {
            var numbers = self.winningNumbers.shuffled().enumerated().compactMap { $0 < matchingCount ? $1 : nil }
            numbers.append(Int.random(in: 1...45))
            lottery = Lottery(numbers: numbers)
        }
        
        let expectedRanking = 3
        let expectedPrize = 1_500_000
        
        // when
        let checkedLottery = winningChecker.checkedLottery(for: lottery)
        
        // then
        XCTAssertEqual(checkedLottery.ranking, expectedRanking)
        XCTAssertEqual(checkedLottery.prize, expectedPrize)
    }
    
    func testCheckFourthWinning() {
        // given
        let winningChecker = LotteryWinningChecker(winningNumbers: self.winningNumbers, bonusNumber: self.bonusNumber)
        let matchingCount = 4
        var lottery = Lottery(numbers: self.winningNumbers)
        
        while Set(lottery.numbers).intersection(self.winningNumbers).count != matchingCount {
            let numbers = self.winningNumbers.shuffled().enumerated().compactMap { $0 < matchingCount ? $1 : nil }
            lottery = Lottery(numbers: numbers)
        }
        
        let expectedRanking = 4
        let expectedPrize = 50_000
        
        // when
        let checkedLottery = winningChecker.checkedLottery(for: lottery)
        
        // then
        XCTAssertEqual(checkedLottery.ranking, expectedRanking)
        XCTAssertEqual(checkedLottery.prize, expectedPrize)
    }
    
    func testCheckFifthWinning() {
        // given
        let winningChecker = LotteryWinningChecker(winningNumbers: self.winningNumbers, bonusNumber: self.bonusNumber)
        let matchingCount = 3
        var lottery = Lottery(numbers: self.winningNumbers)
        
        while Set(lottery.numbers).intersection(self.winningNumbers).count != matchingCount {
            let numbers = self.winningNumbers.shuffled().enumerated().compactMap { $0 < matchingCount ? $1 : nil }
            lottery = Lottery(numbers: numbers)
        }
        
        let expectedRanking = 5
        let expectedPrize = 5_000
        
        // when
        let checkedLottery = winningChecker.checkedLottery(for: lottery)
        
        // then
        XCTAssertEqual(checkedLottery.ranking, expectedRanking)
        XCTAssertEqual(checkedLottery.prize, expectedPrize)
    }
    
    func testCheckLosing() {
        // given
        let winningChecker = LotteryWinningChecker(winningNumbers: self.winningNumbers, bonusNumber: self.bonusNumber)
        let matchingMaximumCount = 2
        var lottery = Lottery(numbers: self.winningNumbers)
        
        while Set(lottery.numbers).intersection(self.winningNumbers).count > matchingMaximumCount {
            lottery = Lottery()
        }
        
        let expectedRanking = 6
        let expectedPrize = 0
        
        // when
        let checkedLottery = winningChecker.checkedLottery(for: lottery)
        
        // then
        XCTAssertEqual(checkedLottery.ranking, expectedRanking)
        XCTAssertEqual(checkedLottery.prize, expectedPrize)
    }
    
}
