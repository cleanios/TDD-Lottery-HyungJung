//
//  LotteryPurchaser.swift
//  SimpleLottery
//
//  Created by HyungJung Kim on 18/03/2019.
//  Copyright © 2019 HyungJung Kim. All rights reserved.
//

import Foundation

class LotteryPurchaser {
    
    private(set) var lotteries: [Lottery] = []
    
    func purchase(for purchaseAmount: Int) {
        var lotteries: [Lottery] = []
        
        let purchasableCount = purchaseAmount / Lottery.price
        
        while lotteries.count < purchasableCount {
            lotteries.append(Lottery())
        }
        
        print("You purchased \(lotteries.count) lottories.")
        lotteries.forEach { print($0.numbers) }
        
        self.lotteries.append(contentsOf: lotteries)
    }
    
}
