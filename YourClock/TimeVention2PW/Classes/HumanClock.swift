//
//  HalfLife.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 1/15/18.
//  Copyright © 2018 Corey Wade. All rights reserved.
//

import Foundation

enum Human: Int, CaseCountable {
    case heartBeat, breaths, redBloodCells, skinreplacements, redbloodcellcount, bloodcelllifetimes, neuronsfiring, atoms
}

class HumanClock: Clock {

    override init(date: Date) {
        super.init(date: date)
    }
    
    let name = "Human Clock"

    func units(human: Human) -> (Double, String, Int) {
        var units: (Double, String, Int)
    switch human {
    case .heartBeat : units = (4/3.0, "Heartbeats", 0)
    case .breaths : units = (4/15.0, "Breaths", 0)
    case .redBloodCells : units = (1/60.0, "Red Blood Cell Circulations", 2)
    case .skinreplacements: units = (1/(27*86400.0) , "Skin Regenerations", 7)
    case .redbloodcellcount: units = (30.0+(30.0/(120*86400)), "Cumulative Red Blood Cells", 0) //billion divisor
    case .bloodcelllifetimes: units = (1.0/10368000, "Blood Cell Lifetimes", 7)
    case .neuronsfiring: units = (100*0.1, "Neurons Fired", 0) //billion divider
    case .atoms: units = (7000.0 + 7000.0*0.98/yearSecs, "Body Atoms", 0) //septillion divisor
        }
        return units
    }

    func additionalLabel(human: Human) -> String {
        var label: String
        switch human {
        case .heartBeat : label = "On average, the human heart beats 50-90 times per minute on average."
        case .breaths: label = "Adults take 12-18 breaths per minute, while infants take 30-40."
        case .skinreplacements: label = "Human skin renews itself every 27 days."
        case .redBloodCells: label = "For each circulation, a red blood cell leaves the heart, passes oxygen to the body, then returns to the heart."
        case .bloodcelllifetimes: label = "The functional lifetime of a red blood cell is 100-120 days."
        case .redbloodcellcount: label = "Humans contain 20-30 trillion red blood cells at any given time."
        case .neuronsfiring: label = "There are 85-86 billion neurons in an adult human brain."
        case .atoms: label = "There are 7 octillion atoms in the human body at any given time."
        }
        return label
    }

    func totalUnits (date: Date, human: Human) -> Double {
        let earthSeconds = self.totalSeconds(date: date)
        let units = self.units(human: human)
        return units.0 * earthSeconds
    }

    func label(human: Human) -> String {
        let units = self.units(human: human)
        return units.1
    }

    func suffix(human: Human) -> String {
        var suffix : String
        switch human {
        case .skinreplacements : suffix = ""
        case .neuronsfiring : suffix = " billion"
        case .redbloodcellcount : suffix = " trillion"
        case .atoms : suffix = " septillion"
        default : suffix = ""
        }
        return suffix
    }
    
    func futureNumber(date: Date, human: Human) -> Int{
        let units = Int(self.totalUnits(date: date, human: human))
        let nextNumber : Int
        nextNumber = nextNumZeroes2(x: units).0
        return nextNumber
    }
    
    func futureNumberString(date: Date, human: Human) -> String {
        let nextNumber = futureNumber(date: date, human: human)
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        let formattedNumber = numberFormatter.string(from: NSNumber(value:nextNumber))
        return formattedNumber!
    }
    
    func futureDate(date: Date, human: Human) -> Date {
        let myUnits = Int(self.totalUnits(date: date, human: human))
        let nextNumber : Int
        nextNumber = Int(Double(nextNumZeroes2(x: myUnits).0) / units(human: human).0)
        let futureDate = futureDateAdjusted(date: date, nextNumber: nextNumber)
        return futureDate
    }
    
    func futureDateString(date: Date, human: Human) ->  String {
        let futureDate = self.futureDate(date: date, human: human)
        let myFormatter = DateFormatter()
        myFormatter.dateStyle = .long
        myFormatter.timeStyle = .medium
        return myFormatter.string(from: futureDate)
    }
    
    func futureTextLabel (date: Date, human: Human) -> String {
        let formattedNumber = futureNumberString(date: date, human: human)
        let futureDate = self.futureDateString(date: date, human: human)
        let label = self.units(human: human).1
        return " will reach \(formattedNumber)\(suffix(human: human)) \(label) on \(futureDate)."
    }
    
    func futureCalendarLabel(date: Date, human: Human) -> String {
        let formattedNumber = futureNumberString(date: date, human: human)
        let label = self.units(human: human).1
        return " reaches \(formattedNumber)\(suffix(human: human)) \(label)"
    }

    func numberFormatterYears (date: Date, human: Human) -> String {
        numberFormatter.maximumFractionDigits = self.units(human: human).2
        numberFormatter.minimumFractionDigits = self.units(human: human).2
        let display = numberFormatter.string(from: NSNumber(value: totalUnits(date: date, human: human)))
        let suffix = self.suffix(human: human)
        return display! + suffix
    }
}

