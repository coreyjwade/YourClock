//
//  FunClock.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 12/29/17.
//  Copyright © 2017 Corey Wade. All rights reserved.
//


import Foundation

enum Fun : Int, CaseCountable {
    case snowflakes, flick, jiffy, dirac, mileway, cicada, hairSecond
}

class FunClock: Clock {
    override init(date: Date) {
        super.init(date: date)
    }
    let name = "Fun"
    
func units(fun: Fun) -> (Double, String, Int) {
        var units: (Double, String, Int)
        switch fun {
        case .hairSecond: units = (6.0/yearSecs, "Inches of Hair Growth", 7)
        case .jiffy: units = (60.0, "Jiffies", 0)
        case .dirac: units = (1/3600.0, "Diracs", 3)
        case .mileway: units = (1/1200.0, "Mileways", 4)
        case .cicada : units = ((1/536467732.0), "Cicada Breeding Cycles", 9)
        case .snowflakes : units = (1000000000000/(365.256*86400), "Fallen Snowflakes", 0) //12 zeroes removed
        case .flick: units = (705.6, "Flicks", 0) //6 zeroes removed
        }
        return units
    }
    
func totalUnits (date: Date, fun: Fun) -> Double {
        let earthSeconds = self.totalSeconds(date: date)
        let units = self.units(fun: fun)
        return units.0 * earthSeconds
    }

    func label(fun: Fun) -> String {
        let units = self.units(fun: fun)
        return units.1
    }

    func futureNumber(date: Date, fun: Fun) -> Int{
        let units = Int(self.totalUnits(date: date, fun: fun))
        let nextNumber : Int
        nextNumber = nextNumZeroes2(x: units).0
        return nextNumber
    }
    
    func futureNumberString(date: Date, fun: Fun) -> String {
        let nextNumber = futureNumber(date: date, fun: fun)
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        let formattedNumber = numberFormatter.string(from: NSNumber(value:nextNumber))
        return formattedNumber!
    }
    
    func futureDate(date: Date, fun: Fun) -> Date {
        let myUnits = Int(self.totalUnits(date: date, fun: fun))
        let nextNumber : Int
        nextNumber = Int(Double(nextNumZeroes2(x: myUnits).0) / units(fun: fun).0)
        let futureDate = futureDateAdjusted(date: date, nextNumber: nextNumber)
        return futureDate
    }
    
    func futureDateString(date: Date, fun: Fun) ->  String {
        let futureDate = self.futureDate(date: date, fun: fun)
        let myFormatter = DateFormatter()
        myFormatter.dateStyle = .long
        myFormatter.timeStyle = .medium
        return myFormatter.string(from: futureDate)
    }
    
    func futureTextLabel (date: Date, fun: Fun) -> String {
        let formattedNumber = futureNumberString(date: date, fun: fun)
        let futureDate = self.futureDateString(date: date, fun: fun)
        let label = self.units(fun: fun).1
        return " will reach \(formattedNumber)\(suffix(fun:fun)) \(label) on \(futureDate)."
    }
    
    func futureCalendarLabel(date: Date, fun: Fun) -> String {
        let formattedNumber = futureNumberString(date: date, fun: fun)
        let label = self.units(fun: fun).1
        return " turns \(formattedNumber)\(suffix(fun:fun)) \(label)"
    }
    
    func additionalLabel(fun: Fun) -> String {
        var label: String
        switch fun {
        case .hairSecond: label = "Each strand of hair on the human body grows at its own rate."
        case .jiffy: label = "A jiffy is the time it takes light to travel one Fermi. A Fermi is one quadrillionth of one."
        case .dirac: label = "A Dirac, named after physicist Paul Dirac, is one word per hour."
        case .mileway: label = "A Mileway is the number of miles covered at the average walking pace."
        case .cicada: label = "After 17 years of living underground, cicadas finally emerge to mate."
        case .snowflakes: label = "Over a trillion snowflakes fall to Earth every second."
        case .flick: label = "Used to sync video frame rates, a flick is 1/705,600,000 of a second."
        }
        return label
    }
    
    func suffix(fun: Fun) -> String {
        var suffix : String
        switch fun {
        case .snowflakes : suffix = " trillion"
        case .flick : suffix = " million"
        default : suffix = ""
        }
        return suffix
    }

    func numberFormatterYears (date: Date, fun: Fun) -> String {
        numberFormatter.maximumFractionDigits = self.units(fun: fun).2
        numberFormatter.minimumFractionDigits = self.units(fun: fun).2
        let display = numberFormatter.string(from: NSNumber(value: totalUnits(date: date, fun: fun)))
        let suffix = self.suffix(fun: fun)
        return display! + suffix
    }
}

