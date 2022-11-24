//
//  Score.swift
//  MyCreditManager
//
//  Created by 소하 on 2022/11/24.
//

import Foundation

struct Score {
    var subjects:String
    var subjectsScore:String
    
    func getScore() -> CGFloat {
        switch subjectsScore {
        case "A+":
            return 4.5
        case "A":
            return 4.0
        case "B+":
            return 3.5
        case "B":
            return 3.0
        case "C+":
            return 2.5
        case "C":
            return 2.0
        case "D+":
            return 1.5
        case "D":
            return 1.0
        case "F":
            return 0
        default:
            return 0
        }
    }
}

