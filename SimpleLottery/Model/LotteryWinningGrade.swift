//
//  LotteryWinningGrade.swift
//  SimpleLottery
//
//  Created by HyungJung Kim on 19/03/2019.
//  Copyright © 2019 HyungJung Kim. All rights reserved.
//

import Foundation

protocol LotteryWinningGrade {
    
    var ranking: Int { get }
    var prize: Int { get }
    
}


struct FirstWinning: LotteryWinningGrade {
    
    var ranking = 1
    var prize = 2_000_000_000
    
}


struct SecondWinning: LotteryWinningGrade {
    
    var ranking = 2
    var prize = 30_000_000
    
}


struct ThirdWinning: LotteryWinningGrade {
    
    var ranking = 3
    var prize = 1_500_000
    
}


struct FourthWinning: LotteryWinningGrade {
    
    var ranking = 4
    var prize = 50_000
    
}


struct FifthWinning: LotteryWinningGrade {
    
    var ranking = 5
    var prize = 5_000
    
}


struct Losing: LotteryWinningGrade {
    
    var ranking = 6
    var prize = 0
    
}


struct LotteryWinningGradeFactory {
    
    static func winningGrade(for matchingCount: Int, hasBonus: Bool) -> LotteryWinningGrade {
        switch matchingCount {
        case 6:
            return FirstWinning()
        case 5:
            return hasBonus ? SecondWinning() : ThirdWinning()
        case 4:
            return FourthWinning()
        case 3:
            return FifthWinning()
        default:
            return Losing()
        }
    }
    
}
