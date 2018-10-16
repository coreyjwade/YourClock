//
//  StandardClock.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 12/21/17.
//  Copyright © 2017 Corey Wade. All rights reserved.
//

import Foundation

let userCalendar = Calendar.current

var specialCase = false

//StandardClock contains built-in Apple Methods for standard units of time
class StandardClock : Clock {
    override init(date: Date) {
        super.init(date: date)
    }
    
    var name = "Standard"
    let count = 7
    
    //returns total units in time interval as Date Component (reads like an Int)
    func totalUnits (date: Date, unit: Calendar.Component) -> DateComponents {
        let now = Date()
        let totalUnits = userCalendar.dateComponents([unit], from: date, to: now)
        return totalUnits
    }
    
    //converts units from components into double with label
    //and number of decimal places for output to update every tenth of a second
    func units(date: Date, unit: Calendar.Component) -> (Double) {
        var totalUnits = self.totalUnits(date: date, unit: unit)
        var time: Double
        switch unit {
        case .minute: time = Double(totalUnits.minute!)
        case .hour: time = Double(totalUnits.hour!)
        case .day: time = Double(totalUnits.day!)
        case .weekOfYear: time = Double(totalUnits.weekOfYear!)
        case .month: time = Double(totalUnits.month!)
        case .year: time = Double(totalUnits.year!)
        default: time = totalSeconds(date: date)
        }
        return time
    }
    
    func info (unit: Calendar.Component) -> (label: String, decimalPlaces: Int){
        var info: (String, Int)
        switch unit {
        case .minute: info = ("Minutes", 3)
        case .hour: info = ("Hours", 5)
        case .day: info = ("Days", 6)
        case .weekOfYear: info = ("Weeks", 7)
        case .month: info = ("Months", 8)
        case .year: info = ("Years", 9)
        default: info = ("Seconds", 1)
        }
        return info
    }
    
    //computes decimal units since apple only provides ints
    func remainder (unit: Calendar.Component) -> Double {
        var remainder: Double
        let secs = self.totalSeconds(date: date)
        switch unit {
        case .minute:
            let mins = units(date: date, unit: .minute)
            remainder = (secs - mins*60)/60
        case .hour:
            let hours = units(date: date, unit: .hour)
            remainder = (secs - hours*3600)/3600
        case .day:
            let days = units(date: date, unit: .day)
            remainder = (secs - days*86400)/86400
        case .weekOfYear:
            let weeks = units(date: date, unit: .weekOfYear)
            remainder = (secs - weeks*7*86400)/(7*86400)
        case .month:
            let months = Int(units(date: date, unit: .month))
            let firstDateMonth = userCalendar.date(byAdding: .month, value: months, to: date)
            let secondDateMonth = userCalendar.date(byAdding: .month, value: 1, to: firstDateMonth!)
            let now = Date()
            let monthPartialSecs = now.timeIntervalSince(firstDateMonth!)
            let monthTotalSecs = secondDateMonth?.timeIntervalSince(firstDateMonth!)
            remainder = monthPartialSecs/monthTotalSecs!
        case .year:
            let years = Int(units(date: date, unit: .year))
            let firstDateYear = userCalendar.date(byAdding: .year, value: years, to: date)
            let secondDateYear = userCalendar.date(byAdding: .year, value: 1, to: firstDateYear!)
            let now = Date()
            let yearPartialSecs = now.timeIntervalSince(firstDateYear!)
            let yearTotalSecs = secondDateYear?.timeIntervalSince(firstDateYear!)
            remainder = yearPartialSecs/yearTotalSecs!
        default: remainder = 0
        }
        return remainder
    }
    
    //converts units into decimal representation for display
    func decimalValue(date: Date, unit: Calendar.Component) -> Double {
        let units = self.units(date: date, unit: unit)
        let decimalValue = units + remainder(unit: unit)
        return decimalValue
    }
    
    func label(unit: Calendar.Component) -> String {
//        let suffix = " on Earth"
        let main = info(unit: unit).label
        return main
    }
    
    func helpfulLabel(unit: Calendar.Component) -> String {
        var label: String
        switch unit {
        case .second: label = "seconds"
        case .minute: label = "minutes"
        case .hour: label = "hours"
        case .day: label = "days"
        case .weekOfYear: label = "weeks"
        case .month: label = "months"
        case .year: label = "years"
        default: label = ""
        }
        return label
    }
    
    func additionalLabel(unit: Calendar.Component) -> String {
        var label: String
        switch unit {
        case .second: label = "The second is elastic due to tidal friction slowing the Earth's rotation."
        case .minute: label = "Since 1972, 27 minutes have been 61 seconds long."
        case .hour: label = "An hour ranges from 3,599 to 3,601 seconds depending upon conditions."
        case .day: label = "There are 86,400 seconds each day excluding leap seconds."
        case .weekOfYear: label = "A week is the standard period used for cycles of rest days in most parts of the world."
        case .month: label = "A month, based on the phases of the moon, was used to count time in the Paleolithic era."
        case .year: label = "According to recent estimates, there are 365.256363004 days per year."
        default: label = ""
        }
        return label
    }
    
    //computes milestone number
    func futureNumber(date: Date, unit: Calendar.Component) -> Int {
        let units = Int(self.units(date: date, unit: unit))
        var nextNumber : Int
        if unit == .month {
            nextNumber = nextNumZeroes2(x: units).0
        }
        else {
            nextNumber = nextNumZeroes2(x: units).1
        }
        return nextNumber
    }
    
    //converts milestone number to string
    func futureNumberString(date: Date, unit: Calendar.Component) -> String {
        let nextNumber = futureNumber(date: date, unit: unit)
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        let formattedNumber = numberFormatter.string(from: NSNumber(value:nextNumber))
        return formattedNumber!
    }
    
    //computes date user will turn milestone number
    func futureDate(date: Date, unit: Calendar.Component) -> Date {
        let nextNumber = futureNumber(date: date, unit: unit)
        var futureDate = userCalendar.date(byAdding: unit, value: nextNumber, to: date)
        //Dates are not computing correctly in the 1950s presumably when the total seconds are over 2 billion.
        if unit == .second && totalSeconds(date: date) > 1800000000 {
            let changeNumber = nextNumber / 3600
            let remainder = nextNumber - changeNumber * 3600
            let hourDate = userCalendar.date(byAdding: .hour, value: changeNumber, to: date)
            futureDate = userCalendar.date(byAdding: unit, value: remainder, to: hourDate!)
        }
        return futureDate!
    }
    
    //converts date user will turn mileston number to string
    func futureDateString(date: Date, unit: Calendar.Component) -> String {
        let futureDate = self.futureDate(date: date, unit: unit)
        let myFormatter = DateFormatter()
        myFormatter.dateStyle = .long
        myFormatter.timeStyle = .medium
        return myFormatter.string(from: futureDate)
    }
    
    //presents label for text-based outputs
    func futureTextLabel(date: Date, unit: Calendar.Component) -> String {
        let formattedNumber = futureNumberString(date: date, unit: unit)
        let futureDate = self.futureDateString(date: date, unit: unit)
        var label = helpfulLabel(unit: unit)
        var mix : String
        if specialCase {
            mix = "/0/0 0:00:00"
            label = ""
        }
        else {
            mix = ""
        }
        return " will turn \(formattedNumber)\(mix) \(label) on \(futureDate)."
    }
    
    //presents label for storing calendar dates
    func futureCalendarLabel(date: Date, unit: Calendar.Component) -> String {
        let formattedNumber = futureNumberString(date: date, unit: unit)
        let label = helpfulLabel(unit: unit)
        return " turns \(formattedNumber) \(label)"
    }
    
    //chooses decimal places and adds commas
    func numberFormatter (date: Date, unit: Calendar.Component) -> String {
        numberFormatter.maximumFractionDigits = info(unit: unit).decimalPlaces
        numberFormatter.minimumFractionDigits = info(unit: unit).decimalPlaces
        let decimalValue = self.decimalValue(date: date, unit: unit)
        let display = numberFormatter.string(from: NSNumber(value: decimalValue))
        return display!
    }
    
    func diffClock(date: Date)->String {
        let diff =  userCalendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: Date())
        let year = String(diff.year!)
        let month = String(diff.month!)
        let day = String(diff.day!)
        let hour = String(diff.hour!)
        let min = String(diff.minute!)
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        let sec = formatter.string(from: NSNumber(value: diff.second!))
        let half1 = year + "/" + month + "/" + day + " "
        let half2 = hour + ":" + min + ":" + sec!
        return half1 + half2
    }
}


