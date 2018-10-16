//
//  LightSpeed.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 1/15/18.
//  Copyright © 2018 Corey Wade. All rights reserved.
//

import Foundation

enum Classical : Int, CaseCountable {
    case fortnight, olympiad, lustrum, decade, indiction, century, millenia
}

class ClassicalClock : StandardClock {
    override init(date: Date) {
        super.init(date: date)
    }
    override var name : String {
        get {
            return "Classical Standards"
        }
        set { // Do Nothing
        }
    }
    
    func conversionUnits(classical: Classical, date: Date) -> Double {
        var info : Double
        switch classical {
        case .fortnight: info = self.decimalValue(date: date, unit: .day)
        default: info = self.decimalValue(date: date, unit: .year)
        }
        return info
    }
    
    func units (date: Date, classical: Classical) -> (Double, String, Int) {
        var info: (Double, String, Int)
        switch classical {
        case .fortnight: info = (self.decimalValue(date: date, unit: .day)/14, "Fortnights", 6)
        case .olympiad: info = (self.decimalValue(date: date, unit: .year)/4, "Olympiads", 9)
        case .lustrum: info = (self.decimalValue(date: date, unit: .year)/5, "Lustrums", 9)
        case .decade: info = (self.decimalValue(date: date, unit: .year)/10, "Decades", 10)
        case .indiction: info = (self.decimalValue(date: date, unit: .year)/15, "Indictions", 10)
        case .century: info = (self.decimalValue(date: date, unit: .year)/100, "Centuries", 11)
        case .millenia: info = (self.decimalValue(date: date, unit: .year)/1000, "Millenia", 12)
        }
        return info
    }
    
    func num(classical: Classical) -> Int {
        var num: Int
        switch classical {
        case .fortnight: num = 14
        case .olympiad: num = 4
        case .lustrum: num = 5
        case .decade: num = 10
        case .indiction: num = 15
        case .century: num = 100
        case .millenia: num = 1000
        }
        return num
    }
    
    func futureNumber(date: Date, classical: Classical) -> Int{
        let units = Int(self.units(date: date, classical: classical).0)
        let nextNumber : Int
        nextNumber = nextNumZeroes2(x: units).0
        return nextNumber
    }
    
    func futureNumberString(date: Date, classical: Classical) -> String {
        let nextNumber = futureNumber(date: date, classical: classical)
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        let formattedNumber = numberFormatter.string(from: NSNumber(value:nextNumber))
        return formattedNumber!
    }
    
    func futureDate(date: Date, classical: Classical) -> Date {
        let myUnits = Int(self.units(date: date, classical: classical).0)
        let nextNumber: Int
        var futureDate: Date
        nextNumber = nextNumZeroes2(x: myUnits).0 * num(classical: classical)
        if classical == .fortnight {
            futureDate = userCalendar.date(byAdding: .day, value: nextNumber, to: date)!
        }
        else {
            futureDate = userCalendar.date(byAdding: .year, value: nextNumber, to: date)!
        }
        return futureDate
    }
    
    func futureDateString(date: Date, classical: Classical) ->  String {
        let futureDate = self.futureDate(date: date, classical: classical)
        let myFormatter = DateFormatter()
        myFormatter.dateStyle = .long
        myFormatter.timeStyle = .medium
        return myFormatter.string(from: futureDate)
    }
    
    func futureTextLabel (date: Date, classical: Classical) -> String {
        let formattedNumber = futureNumberString(date: date, classical: classical)
        let futureDate = self.futureDateString(date: date, classical: classical)
        let label = self.units(date: date, classical: classical).1
        return " will reach \(formattedNumber) \(label) on \(futureDate)."
    }
    
    func futureCalendarLabel(date: Date, classical: Classical) -> String {
        let formattedNumber = futureNumberString(date: date, classical: classical)
        let label = self.units(date: date, classical: classical).1
        return " reaches \(formattedNumber) \(label)"
    }
    
    func additionalLabel2(classical: Classical) -> String {
        var label: String
        switch classical {
        case .fortnight: label = "Fortnight derives from old English meaning fourteen nights."
        case .olympiad: label = "The first Olympiad, a period of four years, was held in Ancient Greece from 776 to 772 BCE."
        case .lustrum: label = "The lustrum, a five year period in Ancient Rome, was an animal sacrfice after the five-year census."
        case .decade: label = "Since the first decade started at the year 1, and decade means group of ten, the last year of each decade ends with a 0."
        case .indiction: label = "An indiction is a fifteen year cycle used to date medieval documents."
        case .century: label = "Strict Usage and Common Usage disagree on whether the year 2000 is part of the 20th or 21st Century."
        case .millenia: label = "A millenium, a one thousand year period, is also called a kiloyear."
        }
        return label
    }
    
    func numberFormatterYears (date: Date, classical: Classical) -> String {
        numberFormatter.maximumFractionDigits = self.units(date: date, classical: classical).2
        numberFormatter.minimumFractionDigits = self.units(date: date, classical: classical).2
        let display = numberFormatter.string(from: NSNumber(value: units(date: date, classical: classical).0))
        return display!
    }
    
    func label(classical: Classical, date: Date) -> String {
        let units = self.units(date: date, classical: classical)
        return units.1
    }
    
}

