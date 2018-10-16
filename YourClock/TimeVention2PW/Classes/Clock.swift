//
//  Clock.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 12/18/17.
//  Copyright © 2017 Corey Wade. All rights reserved.
//

import Foundation

var yearSecs = 86400*365.256363004

protocol CaseCountable {
    static var caseCount: Int { get }
}

extension CaseCountable where Self: RawRepresentable, Self.RawValue == Int {
    internal static var caseCount: Int {
        var count = 0
        while let _ = Self(rawValue: count) {
            count += 1
        }
        return count
    }
}

enum Clocks : Int, CaseCountable {
    case standard = 0, planets, exoplanets, galactic, fun, sports, halfLife, human, lightSpeed, classical
}

class Clock {
    
    let numberFormatter = NumberFormatter()
    
    //date is generated from user via date and time pickers
    var date: Date
    init(date: Date) {
        self.date = date
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
    }
    
    //totalSeconds is the standard unit of clock conversion
    func totalSeconds(date: Date) -> Double {
        let now = Date()
        let totalSeconds = now.timeIntervalSince(date)
        return totalSeconds
    }
    
    func checkOverflow(date:Date)->Bool{
        if totalSeconds(date: date) > 18000000000 {
            return true
        }
        else {
            return false
        }
    }
    
    func futureDateAdjusted (date: Date, nextNumber: Int) -> Date {
            let changeNumber = nextNumber / 3600
            let remainder = nextNumber - changeNumber * 3600
            let hourDate = userCalendar.date(byAdding: .hour, value: changeNumber, to: date)
            let futureDate = userCalendar.date(byAdding: .second, value: remainder, to: hourDate!)!
            return futureDate
        }
    }

