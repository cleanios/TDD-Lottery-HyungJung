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
    
    func testGeneratedNumbersCount_ShouldBeEqualToLotteryNumbersCount() {
        // given
        
        // when
        let lottery = Lottery()
        
        // then
        XCTAssertEqual(lottery.numbers.count, Lottery.numbersCount)
    }
    
    func testGeneratedNumbers_ShouldBeInLotteryNumberRange() {
        // given
        
        // when
        let lottery = Lottery()
        
        // then
        lottery.numbers.forEach { XCTAssertTrue(Lottery.numberRange.contains($0)) }
    }
    
    func testGeneratedNumbers_WhenNumbersCountIsExceeded_ShouldBeEqualToLotteryNumbersCount() {
        // given
        var uniqueNumbers: Set<Int> = []
        
        while uniqueNumbers.count < Lottery.numbersCount + 1 {
            uniqueNumbers.insert(Int.random(in: Lottery.numberRange))
        }
        
        // when
        let lottery = Lottery(numbers: Array(uniqueNumbers).sorted())
        
        // then
        XCTAssertEqual(lottery.numbers.count, Lottery.numbersCount)
    }
    
    func testGeneratedNumbers_WhenNumbersCountIsExceeded_ShouldBeInLotteryNumberRange() {
        // given
        var uniqueNumbers: Set<Int> = []
        
        while uniqueNumbers.count < Lottery.numbersCount + 1 {
            uniqueNumbers.insert(Int.random(in: Lottery.numberRange))
        }
        
        // when
        let lottery = Lottery(numbers: Array(uniqueNumbers).sorted())
        
        // then
        lottery.numbers.forEach { XCTAssertTrue(Lottery.numberRange.contains($0)) }
    }
    
    func testPurchaseLotteries() {
        // given
        let purchaseAmount = 5000
        let purchaser = LotteryPurchaser()
        
        let expectedCount = purchaseAmount / Lottery.price
        
        // when
        purchaser.purchase(for: purchaseAmount)
        
        // then
        XCTAssertEqual(purchaser.lotteries.count, expectedCount)
    }
    
    func testCheckFirstWinning() {
        // given
        let lottery = Lottery(numbers: self.winningChecker.winningNumbers)
        
        let expectedRanking = 1
        let expectedPrize = 2_000_000_000
        
        // when
        let checkedLottery = self.winningChecker.checkedLottery(for: lottery)
        
        // then
        XCTAssertEqual(checkedLottery.ranking, expectedRanking)
        XCTAssertEqual(checkedLottery.prize, expectedPrize)
    }
    
    func testCheckSecondWinning() {
        // given
        let matching = 5
        var numbers = self.winningChecker.winningNumbers.shuffled().enumerated().compactMap { $0 < matching ? $1 : nil }
        numbers.append(self.winningChecker.bonusNumber)
        let lottery = Lottery(numbers: numbers)
        
        let expectedRanking = 2
        let expectedPrize = 30_000_000
        
        // when
        let checkedLottery = self.winningChecker.checkedLottery(for: lottery)
        
        // then
        XCTAssertEqual(checkedLottery.ranking, expectedRanking)
        XCTAssertEqual(checkedLottery.prize, expectedPrize)
    }
    
    func testCheckThirdWinning() {
        // given
        let matching = 5
        var lottery = Lottery(numbers: [self.winningChecker.bonusNumber])
        
        while lottery.numbers.contains(self.winningChecker.bonusNumber) {
            var numbers = self.winningChecker.winningNumbers.shuffled().enumerated().compactMap { $0 < matching ? $1 : nil }
            numbers.append(Int.random(in: 1...45))
            lottery = Lottery(numbers: numbers)
        }
        
        let expectedRanking = 3
        let expectedPrize = 1_500_000
        
        // when
        let checkedLottery = self.winningChecker.checkedLottery(for: lottery)
        
        // then
        XCTAssertEqual(checkedLottery.ranking, expectedRanking)
        XCTAssertEqual(checkedLottery.prize, expectedPrize)
    }
    
    func testCheckFourthWinning() {
        // given
        let mathcing = 4
        var lottery = Lottery(numbers: self.winningChecker.winningNumbers)
        
        while Set(lottery.numbers).intersection(self.winningChecker.winningNumbers).count != mathcing {
            let numbers = self.winningChecker.winningNumbers.shuffled().enumerated().compactMap { $0 < mathcing ? $1 : nil }
            lottery = Lottery(numbers: numbers)
        }
        
        let expectedRanking = 4
        let expectedPrize = 50_000
        
        // when
        let checkedLottery = self.winningChecker.checkedLottery(for: lottery)
        
        // then
        XCTAssertEqual(checkedLottery.ranking, expectedRanking)
        XCTAssertEqual(checkedLottery.prize, expectedPrize)
    }
    
    func testCheckFifthWinning() {
        // given
        let mathcing = 3
        var lottery = Lottery(numbers: self.winningChecker.winningNumbers)
        
        while Set(lottery.numbers).intersection(self.winningChecker.winningNumbers).count != mathcing {
            let numbers = self.winningChecker.winningNumbers.shuffled().enumerated().compactMap { $0 < mathcing ? $1 : nil }
            lottery = Lottery(numbers: numbers)
        }
        
        let expectedRanking = 5
        let expectedPrize = 5_000
        
        // when
        let checkedLottery = self.winningChecker.checkedLottery(for: lottery)
        
        // then
        XCTAssertEqual(checkedLottery.ranking, expectedRanking)
        XCTAssertEqual(checkedLottery.prize, expectedPrize)
    }
    
    func testCheckLosing() {
        // given
        let matching = 2
        var lottery = Lottery(numbers: self.winningChecker.winningNumbers)
        
        while Set(lottery.numbers).intersection(self.winningChecker.winningNumbers).count > matching {
            lottery = Lottery()
        }
        
        let expectedRanking = 6
        let expectedPrize = 0
        
        // when
        let checkedLottery = self.winningChecker.checkedLottery(for: lottery)
        
        // then
        XCTAssertEqual(checkedLottery.ranking, expectedRanking)
        XCTAssertEqual(checkedLottery.prize, expectedPrize)
    }
    
    // MARK: - private
    
    private let winningChecker = LotteryWinningChecker()
    
}
