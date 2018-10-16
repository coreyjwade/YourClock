//
//  HalfLife.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 1/15/18.
//  Copyright © 2018 Corey Wade. All rights reserved.
//

import Foundation

enum Halflife: Int, CaseCountable {
    
    case oxygen12, francium, gold198, tritium, carbon14, uranium234, potassium40, barium, tellurium128 }

class HalflifeClock: Clock {
    
    override init(date: Date) {
        super.init(date: date)
    }
    
    let name = "Half Life"

func units(halflife: Halflife) -> (Double, String, Int) {
    var units: (Double, String, Int)
    switch halflife {
    case .oxygen12: units = (0.000580, "Oxygen-12 Half-lives", 0) //quintillion (-18 zeroes)
        case .francium: units = (60*22, "Francium 223 Half-lives", 5)
        case .uranium234: units = (7750000000000.0, "Uranium-234 Half-lives", 14)
        case .gold198: units = (232800, "Gold-198 Half-lives", 7)
        case .tritium: units = (12.32 * yearSecs, "Tritium Half-lives", 10)
        case .carbon14: units = (5730.0 * yearSecs, "Carbon-14 Half-lives", 13)
        case .potassium40: units = (1251000000.0 * yearSecs, "Potassium-40 Half-lives", 18)
        case .barium: units = (50000000000000000000000000000.0, "Barium-130 Half-lives", 29)
        case .tellurium128: units = (2200000000000000000000000.0 * yearSecs, "Tellurium 128 Half-lives", 33)
        }
        return units
        }
    
    func additionalLabel(halflife: Halflife) -> String {
        var label: String
        switch halflife {
        case .barium: label = "Barium, the 17th most common element in the Earth’s crust, is used in rat poison and x-raying intestines."
        case .francium: label = "Francium is the least stable of all naturally occurring elements. It explodes if you drop it in water."
        case .uranium234: label = "Uranium 234 is employed in dating sediments from marine or lake enviroments."
        case .carbon14: label = "Discovered in 1940, Carbon-14 is used to date fossils and archaeological specimens."
        case .gold198: label = "Gold-198 has been used to treat various diseases including cancer."
        case .tellurium128: label = "Tellurium 128 has the longest half life of all nuclides at 2.2 septillion years, 159.4 billion times longer than the age of the universe."
        case .oxygen12: label = "Oxygen-12 is the shortest lived oxygen isotope. (A quintillion has 18 zeroes.)"
        case .tritium: label = "Tritium, also known as Hydgrogen-3, is the only radioactive hydrogen isotope."
        case .potassium40: label = "Potassium-40 is the largest source of natural radioactivty in humans."
        }
        return label
    }
    
    func totalUnits (date: Date, halflife: Halflife) -> Double {
        let earthSeconds = self.totalSeconds(date: date)
        let units = self.units(halflife: halflife)
        return earthSeconds/units.0
    }
    
    func label(halflife: Halflife) -> String {
    let units = self.units(halflife: halflife)
        return units.1
    }
    
    func suffix(halflife: Halflife) -> String {
        var suffix : String
        switch halflife {
        case .oxygen12 : suffix = " quintillion"
        default : suffix = ""
        }
        return suffix
    }
    
    func futureNumber(date: Date, halflife: Halflife) -> Int{
        let units = Int(self.totalUnits(date: date, halflife: halflife))
        let nextNumber : Int
        nextNumber = nextNumZeroes2(x: units).0
        return nextNumber
    }
    
    func futureNumberString(date: Date, halflife: Halflife) -> String {
        let nextNumber = futureNumber(date: date, halflife: halflife)
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        let formattedNumber = numberFormatter.string(from: NSNumber(value:nextNumber))
        return formattedNumber!
    }
    
    func futureDate(date: Date, halflife: Halflife) -> Date {
        if halflife == .barium || halflife == .tellurium128 {
            return Date()
        }
        else {
        let myUnits = Int(self.totalUnits(date: date, halflife: halflife))
        let nextNumber : Int
        nextNumber = Int(Double(nextNumZeroes2(x: myUnits).0) * units(halflife: halflife).0)
        let futureDate = futureDateAdjusted(date: date, nextNumber: nextNumber)
        return futureDate
        }
    }
    
    func futureDateString(date: Date, halflife: Halflife) ->  String {
        let futureDate = self.futureDate(date: date, halflife: halflife)
        let myFormatter = DateFormatter()
        myFormatter.dateStyle = .long
        myFormatter.timeStyle = .medium
        return myFormatter.string(from: futureDate)
    }
    
    func futureTextLabel (date: Date, halflife: Halflife) -> String {
        let formattedNumber = futureNumberString(date: date, halflife: halflife)
        let futureDate = self.futureDateString(date: date, halflife: halflife)
        let label = self.units(halflife: halflife).1
        return " will reach \(formattedNumber)\(suffix(halflife:halflife)) \(label) on \(futureDate)."
    }
    
    func futureCalendarLabel(date: Date, halflife: Halflife) -> String {
        let formattedNumber = futureNumberString(date: date, halflife: halflife)
        let label = self.units(halflife: halflife).1
        return " reaches \(formattedNumber)\(suffix(halflife:halflife)) \(label)"
    }
    
    func numberFormatterYears (date: Date, halflife: Halflife) -> String {
        numberFormatter.maximumFractionDigits = self.units(halflife: halflife).2
        numberFormatter.minimumFractionDigits = self.units(halflife: halflife).2
        let display = numberFormatter.string(from: NSNumber(value: totalUnits(date: date, halflife: halflife)))
        let suffix = self.suffix(halflife: halflife)
        return display! + suffix
    }
    }
