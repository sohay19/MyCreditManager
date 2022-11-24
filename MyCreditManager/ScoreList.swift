//
//  ScoreList.swift
//  MyCreditManager
//
//  Created by 소하 on 2022/11/24.
//

import Foundation

struct ScoreList {
    var studentName:String
    var scoreList:[Score]
    
    func getAverage() -> CGFloat {
        var subjectsCount = 0.0
        var allScore = 0.0
        for score in scoreList {
            allScore += score.getScore()
            subjectsCount += 1
        }
        var average:CGFloat = allScore / subjectsCount
        average = round(average * 100)
        average /= 100
        return average
    }
}
