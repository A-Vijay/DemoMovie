//
//  CommonCode.swift
//  DemoMovies
//
//  Created by Vijay A on 03/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation
import UIKit

class CommonCode: NSObject {
    
    //MARK: Singleton
    static let shared = CommonCode()
    private override init() {}
    
    func ratingColor(rating:Double) -> UIColor {
           switch rating {
           case 8.0...10.0:
               return UIColor().demoMovieExcellent
           case 6.5...8.0:
               return UIColor().demoMovieGood
           case 5.5...6.5:
               return UIColor().demoMovieAverage
           case 3.0...5.5:
               return UIColor().demoMovieBelowAverage
           case 0.0...3.0:
               return UIColor().demoMoviePoor
           default:
               return UIColor().demoMovieExcellent
           }
       }
    
    func durationTime(time:Int64) -> String {
        let hours = time/60;
        let mins  = hours % 60;
        var hoursText = "hour"
        if hours > 1{
            hoursText = "hours"
        }
        return "\(hours) \(hoursText) \(mins) mins"
    }
}
