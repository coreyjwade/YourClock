//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Clock {
    var date = Date()
    var now = Date()
    
    func totalSeconds (date:Date) -> Double {
        let totalSeconds = now.timeIntervalSince(date)
        return totalSeconds
    }
    
    func totalMinutes (date:Date) -> DateComponents {
        let totalMinutes = Calendar.current.dateComponents([.minute], from: date, to: now)
        return totalMinutes
    }
    
    func totalHours (date:Date) -> DateComponents {
        let totalHours = Calendar.current.dateComponents([.hour], from: date, to: now)
        return totalHours
    }
    
    func decimalMinutes (totalMinutes:DateComponents, totalSeconds: Double) -> Double {
        let minutes = Double(Int(totalMinutes.minute!))
        let remainder = totalSeconds.truncatingRemainder(dividingBy: 60)
        let decimal = Double(remainder)
        let remainderMinutes = decimal/60
        let decimalMinutes = minutes + remainderMinutes
        return decimalMinutes
    }
    
    func numberFormatter (i: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = i
        numberFormatter.minimumFractionDigits = i
    }
}

class Unit: Clock {
    var unit: DateComponents?
    func totalUnits (date:Date) -> DateComponents {
        let totalUnits = Calendar.current.dateComponents([unit], from: date, to: now)
        return totalUnits
    }
}
