//
//  SportsClock.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 1/12/18.
//  Copyright © 2018 Corey Wade. All rights reserved.
//

import Foundation

enum Sport : Int, CaseCountable {
    case topHumanSpeed, fastestSwimmer, fastestMiler, fastestClimbing, fastestSkiing, fastestIceSkater,
    cheetah, falcon, fish, mammal
}

class SportsClock: Clock {
    
    override init(date: Date) {
        super.init(date: date)
    }
    
    let name = "Speed"
    
    func units(sport: Sport) -> (time: Double, label: String, decimalPlaces: Int) {
        var info: (Double, String, Int)
        switch sport {
       //the divisor is the total number of seconds
        case .topHumanSpeed: info = (1/(9.59*16), "Sprinter Miles", 4)
        case .fastestSwimmer: info = (1/(20.27*32), "Freestyle Miles", 3)
        case .fastestMiler: info = (1/239, "Sub-4-Minute Miles", 4)
        case .fastestClimbing: info = (1/587.94008, "Speed Climbing Miles", 4)
        case .fastestSkiing: info = (1/(1.424999867532*16), "Speed Skiing Miles", 3)
        case .fastestIceSkater: info = (1/(3.7766947358676*16), "Speed Skating Miles", 3)
        case .cheetah: info = (1/(5.95*16), "Cheetah Miles", 3)
        case .falcon: info = (1/(1.1184681460272*16), "Peregrine Falcon Miles", 3)
        case .fish: info = (1/43.90243902439, "Black Marlin Miles", 3)
        case .mammal: info = (1/36.363636363636, "Mexican Free-tailed Bat Miles", 3)
        }
        return info
    }
    
    private func time (date: Date, sport: Sport) -> Double {
        let earthSeconds = totalSeconds(date: date)
        let rate = units(sport: sport).time
        return rate*earthSeconds
    }
    
    func label(sport: Sport) -> String {
        let main = self.units(sport: sport).label
        return main
    }
    
    func numberFormatterYears (date: Date, sport: Sport) -> String {
        numberFormatter.maximumFractionDigits = units(sport: sport).decimalPlaces
        numberFormatter.minimumFractionDigits = units(sport: sport).decimalPlaces
        let display = numberFormatter.string(from: NSNumber(value: time(date: date, sport: sport)))
        return display!
    }
    
    func additionalLabel(sport: Sport) -> String {
        var text: String
        switch sport {
        case .fish: text = "Possibly the fastest fish on the planet, the Black Marlin can reach 80 mph."
        case .mammal: text = "Mexican Free-tailed bats reach a horizontal speed of 99 mph."
        case .falcon: text = "The fastest member of the animal kingdom, the peregrine falcon can dive at 200 mph."
        case .cheetah: text = "The fastest land animal, cheetahs can reach 70 mph in short bursts."
        case .fastestIceSkater: text = "Short track speed skaters routinely clock more than 30 mph."
        case .fastestClimbing: text = "Working against gravity, speed climbers cover about 2.5 meters per second."
        case .fastestSkiing: text = "Downhill speed skiers often exceed 90 mph."
        case .fastestSwimmer: text = "Freestyle swimmers choose the front crawl, developed by Richmond Cavill after watching a young boy in the Solomon Islands."
        case .fastestMiler: text = "Roger Bannister first broke the 4-minute-mile in 1952."
        case .topHumanSpeed: text = "The fastest humans can run 27 mph."
        }
        return text
    }

    func futureNumber(date: Date, sport: Sport) -> Int{
        let units = Int(self.time(date: date, sport: sport))
        let nextNumber : Int
        nextNumber = nextNumZeroes2(x: units).0
        return nextNumber
    }
    
    func futureNumberString(date: Date, sport: Sport) -> String {
        let nextNumber = futureNumber(date: date, sport: sport)
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        let formattedNumber = numberFormatter.string(from: NSNumber(value:nextNumber))
        return formattedNumber!
    }
    
    func futureDate(date: Date, sport: Sport) -> Date {
        let myUnits = Int(self.time(date: date, sport: sport))
        let nextNumber : Int
        nextNumber = Int(Double(nextNumZeroes2(x: myUnits).0) / units(sport: sport).0)
        let futureDate =  futureDateAdjusted(date: date, nextNumber: nextNumber)
        return futureDate
    }
    
    func futureDateString(date: Date, sport: Sport) ->  String {
        let futureDate = self.futureDate(date: date, sport: sport)
        let myFormatter = DateFormatter()
        myFormatter.dateStyle = .long
        myFormatter.timeStyle = .medium
        return myFormatter.string(from: futureDate)
    }
    
    func futureTextLabel (date: Date, sport: Sport) -> String {
        let formattedNumber = futureNumberString(date: date, sport: sport)
        let futureDate = self.futureDateString(date: date, sport: sport)
        let label = self.units(sport: sport).1
        return " will reach \(formattedNumber) \(label) on \(futureDate)."
    }
    
    func futureCalendarLabel(date: Date, sport: Sport) -> String {
        let formattedNumber = futureNumberString(date: date, sport: sport)
        let label = self.units(sport: sport).1
        return " turns \(formattedNumber) \(label)"
    }
    
    
    //
//    func futureLabel (date: Date, sport: Sport) -> String {
//        let units = Int(self.time(date: date, sport: sport))
//        let nextNumber : Int
//        nextNumber = nextNumZeroes2(x: units).0
//        numberFormatter.maximumFractionDigits = 0
//        numberFormatter.minimumFractionDigits = 0
//        let formattedNumber = numberFormatter.string(from: NSNumber(value:nextNumber))
//        let futureDate = self.futureDate(date: date, sport: sport)
//        let label = self.units(sport: sport).label
//        return " will reach \(formattedNumber!) \(label) on \(futureDate)."
//    }
//
//    func futureDate(date: Date, sport: Sport) -> String {
//        let myUnits = Int(self.time(date: date, sport: sport))
//        let nextNumber : Double
//        nextNumber = Double(nextNumZeroes2(x: myUnits).0) / (units(sport: sport).0)
//        var futureDate = userCalendar.date(byAdding: .second, value: Int(nextNumber), to: date)
//        if checkOverflow(date: date){
//            futureDate = futureDateAdjusted(date: date, nextNumber: Int(nextNumber))
//        }
//        let myFormatter = DateFormatter()
//        myFormatter.dateStyle = .long
//        myFormatter.timeStyle = .medium
//        return myFormatter.string(from: futureDate!)
//    }
    
}
