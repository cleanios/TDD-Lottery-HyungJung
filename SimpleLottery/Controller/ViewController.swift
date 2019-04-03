//
//  ViewController.swift
//  SimpleLottery
//
//  Created by HyungJung Kim on 28/03/2019.
//  Copyright © 2019 HyungJung Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let purchaser = LotteryPurchaser()
    private let winningChecker = LotteryWinningChecker(winningNumbers: [1, 5, 11, 19, 25, 31], bonusNumber: 7)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    private func setup() {
        let purchaseAmount = 5000
        self.purchaser.purchase(for: purchaseAmount)
        
        let checkedLotteries = self.winningChecker.checkedLotteries(for: self.purchaser.lotteries)
        self.printResult(of: checkedLotteries)
    }
    
    private func printResult(of checkedLotteries: [LotteryWinningGrade]) {
        let losings = checkedLotteries.filter { $0.ranking == 6 }
        let fifthWinnings = checkedLotteries.filter { $0.ranking == 5 }
        let fourthWinnings = checkedLotteries.filter { $0.ranking == 4 }
        let thirdWinnings = checkedLotteries.filter { $0.ranking == 3 }
        let secondWinnings = checkedLotteries.filter { $0.ranking == 2 }
        let firstWinnings = checkedLotteries.filter { $0.ranking == 1 }
        
        let purchaseAmount = Lottery.price * checkedLotteries.count
        let profit = checkedLotteries.reduce(0) { $0 + $1.prize } - purchaseAmount
        let profitRate = Double(profit) / Double(purchaseAmount) * 100.0
        
        print("Number of losings is \(losings.count).")
        print("Number of fifth winnings(￦5000)) is \(fifthWinnings.count).")
        print("Number of fourth winnings(￦50000) is \(fourthWinnings.count).")
        print("Number of third winnings(￦1500000) is \(thirdWinnings.count).")
        print("Number of second winnings(￦30000000) is \(secondWinnings.count).")
        print("Number of first winnings(￦2000000000) is \(firstWinnings.count).")
        print("Profit rate is \(profitRate)%.")
    }
    
}
