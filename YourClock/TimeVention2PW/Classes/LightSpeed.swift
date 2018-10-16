//
//  LightSpeed.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 1/15/18.
//  Copyright © 2018 Corey Wade. All rights reserved.
//

import Foundation

enum LightSpeed : Int, CaseCountable {
    case ten, half, threeFourths, ninety, ninetyNine, ninetyNine9, ninetyNine99, ninetyNine999
}

class LightSpeedClock : StandardClock {
    override init(date: Date) {
        super.init(date: date)
    }
    
    override var name : String {
        get {
            return "Light Speed"
        }
        set {
            // Do Nothing
        }
    }
    
    func lightRatio(ratio:Double, date: Date, unit: Calendar.Component) -> Double {
       //all ratios are in terms of the speed of light
        //t = t0/(1-v2/c2)1/2
        let units = self.decimalValue(date: date, unit: unit)
        let time = units*((1-ratio*ratio).squareRoot())
        return time
    }
    
    func ratio(lightSpeed: LightSpeed) -> Double {
        var num: Double
        switch lightSpeed {
        case .half: num = 0.5
        case .threeFourths: num = 0.75
        case .ninety: num = 0.9
        default: num = 1.0
        }
        return num
    }
    
    func units (lightSpeed: LightSpeed, date: Date) -> (Double, String, Int, Double) {
        var info: (Double, String, Int, Double)
        switch lightSpeed {
        case .half: info = (self.lightRatio(ratio: 0.5, date: date, unit: .year), "Age at 50% Light Speed", 8, 0.5)
        case .threeFourths: info = (self.lightRatio(ratio: 0.75, date: date, unit: .year), "Age at 75% Light Speed", 8, 0.75)
        case .ninety: info = (self.lightRatio(ratio: 0.9, date: date, unit: .year), "Age at 90% Light Speed", 8, 0.9)
        case .ninetyNine: info = (self.lightRatio(ratio: 0.99, date: date, unit: .year), "Age at 99% Light Speed", 8, 0.99)
        case .ninetyNine9: info = (self.lightRatio(ratio: 0.999, date: date, unit: .year), "Age at 99.9% Light Speed", 8, 0.999)
        case .ninetyNine99: info = (self.lightRatio(ratio: 0.9999, date: date, unit: .year), "Age at 99.99% Light Speed", 8, 0.9999)
        case .ninetyNine999: info = (self.lightRatio(ratio: 0.99999, date: date, unit: .year), "Age at 99.999% Light Speed", 8, 0.99999)
        case .ten: info = (self.lightRatio(ratio: 0.10, date: date, unit: .year), "Age at 10% Light Speed", 8, 0.10)
        }
        return info
    }
    
    func futureNumber(date: Date, lightSpeed: LightSpeed) -> Int{
        let units = Int(self.units(lightSpeed: lightSpeed, date: date).0)
        let nextNum : Int
//        nextNumber = nextNumZeroes2(x: units).0
        nextNum = nextNumber(units: units)
        return nextNum
    }
    
    func futureNumberString(date: Date, lightSpeed: LightSpeed) -> String {
        let nextNumber = futureNumber(date: date, lightSpeed: lightSpeed)
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        let formattedNumber = numberFormatter.string(from: NSNumber(value:nextNumber))
        return formattedNumber!
    }
    
    func futureDate(date: Date, lightSpeed: LightSpeed) -> Date {
        let myUnits = Int(self.units(lightSpeed: lightSpeed, date: date).0)
        let ratio = units(lightSpeed: lightSpeed, date: date).3
//        let nextNumber = Int(Double(nextNumZeroes2(x: myUnits).0) / (1-ratio*ratio).squareRoot() * yearSecs)
        let nextNum = Int(Double(nextNumber(units: myUnits)) / (1-ratio*ratio).squareRoot() * yearSecs)
        let futureDate = futureDateAdjusted(date: date, nextNumber: nextNum)
        return futureDate
    }
    
    func futureDateString(date: Date, lightSpeed: LightSpeed) ->  String {
        let futureDate = self.futureDate(date: date, lightSpeed: lightSpeed)
        let myFormatter = DateFormatter()
        myFormatter.dateStyle = .long
        myFormatter.timeStyle = .medium
        return myFormatter.string(from: futureDate)
    }
    
    func futureTextLabel (date: Date, lightSpeed: LightSpeed) -> String {
        let formattedNumber = futureNumberString(date: date, lightSpeed: lightSpeed)
        let futureDate = self.futureDateString(date: date, lightSpeed: lightSpeed)
        let label = self.label(lightSpeed: lightSpeed, date: date).dropFirst(4)
        return " will turn \(formattedNumber) \(label) on \(futureDate)."
    }
    
    func futureCalendarLabel(date: Date, lightSpeed: LightSpeed) -> String {
        let formattedNumber = futureNumberString(date: date, lightSpeed: lightSpeed)
        let label = self.label(lightSpeed: lightSpeed, date: date).dropFirst(4)
        return " turns \(formattedNumber) \(label)"
    }
    
   func additionalLabel1(lightSpeed: LightSpeed) -> String {
        var label: String
        switch lightSpeed {
        case .ten: label = "Proposed by Albert Einstein in 1905, Special Relativity predicts time dilation."
        case .half: label = "Time dilation often goes unnoticed because we are moving so slowly compared to the speed of light."
        case .threeFourths: label = "The faster an object approaches the speed of light, the more time dilation becomes apparent."
        case .ninety: label = "Time dilation has been experimentally verified on atomic clocks, GPS clocks, and Space Shuttle clocks."
        case .ninetyNine: label = "Time dilation makes forward time travel a scientific fact."
        case .ninetyNine9: label = "Gravitational fields are infused with time dilation."
        case .ninetyNine99: label =  "If dated from the birth of Earth, a Mount Everest clock would be 39 hours ahead of a sea level clock."
        case .ninetyNine999: label = "Earth's gravitational time dilation of 38 microseconds per day would accumulate to GPS errors of 10 kilometers per day if uncorrected by relativity."
        }
        return label
    }
    
    func numberFormatterYears (date: Date, lightSpeed: LightSpeed) -> String {
        numberFormatter.maximumFractionDigits = self.units(lightSpeed: lightSpeed, date: date).2
        numberFormatter.minimumFractionDigits = self.units(lightSpeed: lightSpeed, date: date).2
        let display = numberFormatter.string(from: NSNumber(value: units(lightSpeed: lightSpeed, date: date).0))
        return display!
    }
    
    func label(lightSpeed: LightSpeed, date: Date) -> String {
        let units = self.units(lightSpeed: lightSpeed, date: date)
        return units.1
    }
}
