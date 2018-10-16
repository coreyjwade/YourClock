//
//  GalacticClock.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 12/29/17.
//  Copyright © 2017 Corey Wade. All rights reserved.
//

import Foundation

enum Galaxy : Int, CaseCountable {
    case neutrinos, solarSystem, milkyWay, universe, photonCircum, photon, plancktime, ngc1365, rpy
}

class GalacticClock: StandardClock {
    
    override init(date: Date) {
        super.init(date: date)
}

    override var name : String {
        get {
            return "Physics"
        }
        set {
            // Do Nothing
        }
    }
    
    //10 cosmic rays pass through you per second
    func units(galaxy: Galaxy) -> (distance: Double, label: String, decimalPlaces: Int) {
        var info: (Double, String, Int)
        switch galaxy {
//        case .hydrogenAtoms : info = (13798314159.0, "Age of Hydrogen Atoms in Your Body", 9) //equal to age of universe
        case .neutrinos : info = (0.175*50*65, "Neutrino Count", 0) //12 zereos removed
        case .solarSystem : info = (18.5, "Solar Miles", 0)
        case .milkyWay : info = (134.16667, "Milky Way Miles", 0)
        case .universe : info = (361.11111, "Universe Miles", 0)
        case .photon: info = (299792.458, "Photon Kilometers", 0)
        case .photonCircum: info = (187370.286/24874, "Photon Circumnavigations", 0)
//        case .plancktime: info = (18550948324480000000000000000000000000000000, "Planck Time", 0) //31 zeroes!
        case .plancktime: info = (0.0539116, "Planck Time", 0) //42 zeroes removed!
        case .ngc1365: info = (0.00000417318251*31536000, "Black Hole NGC 1365 Rotations", 0)
        case .rpy: info = (0.000000115740741*31536000, "Milli-sieverts of Radiation Absorbed", 0)
        }
        return info
    }
    
    func distanceTraveled (date: Date, galaxy: Galaxy) -> Double {
        let distance = units(galaxy: galaxy).distance
         let earthSeconds = totalSeconds(date: date)
        if galaxy == .plancktime {
            return earthSeconds/distance
        }
            return distance * earthSeconds
        }
    
    func label(galaxy: Galaxy) -> String {
        let main = units(galaxy: galaxy).label
        return main
    }
    
    func suffix(galaxy: Galaxy) -> String {
        var suffix : String
        switch galaxy {
        case .neutrinos : suffix = " trillion"
        case .plancktime : suffix = " tredecillion"
        default : suffix = ""
        }
        return suffix
    }
    
    func additionalLabel(galaxy: Galaxy) -> String {
        var label: String
        switch galaxy {
        case .neutrinos: label = "Neutrino Count displays the total number of neutrinos that have passed through a human body."
        case .solarSystem: label = "Solar Miles reveals the distance Earth has covered traveling at 66,600 mph."
        case .milkyWay: label = "Milky Way Miles is the distance our solar system has traveled at 483,000 mph through the Galaxy."
        case .universe: label = "Universe Miles is our total distance covered as measured against the Cosmic Microwave Background Radiation at 1,300,000 mph."
        case .photonCircum: label = "A Photon Circumnavigation is the number of times a given photon would round the Earth."
        case .photon: label = "Photon Kilmoters reveals the total distance a single photon covers traveling through empty space."
        case .plancktime: label = "Planck Time is the time it takes for light to travel one Planck Length, the shortest possible unit. (A tredecillion has 42 zeroes.)"
        case .ngc1365: label = "The first black hole to be measured for its speed, Black Hole NGC 1365 spins at 84% the speed of light."
        case .rpy: label = "A sievert is the amount of radiation that would deliver one joule of energy to one kilogram of mass. One sievert can sicken someone; eight are lethal."
        }
        return label
    }
    
    func numberFormatterYears (date: Date, galaxy: Galaxy) -> String {
        numberFormatter.maximumFractionDigits = units(galaxy: galaxy).decimalPlaces
        numberFormatter.minimumFractionDigits = units(galaxy: galaxy).decimalPlaces
        let display = numberFormatter.string(from: NSNumber(value: distanceTraveled(date: date, galaxy: galaxy)))
        let suffix = self.suffix(galaxy: galaxy)
        return display! + suffix
    }
    
    func futureNumber(date: Date, galaxy: Galaxy) -> Int{
        let units = Int(self.distanceTraveled(date: date, galaxy: galaxy))
        let nextNumber : Int
        nextNumber = nextNumZeroes2(x: units).0
        return nextNumber
    }
    
    func futureNumberString(date: Date, galaxy: Galaxy) -> String {
        let nextNumber = futureNumber(date: date, galaxy: galaxy)
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        let formattedNumber = numberFormatter.string(from: NSNumber(value:nextNumber))
        return formattedNumber!
    }
    
    func futureDate(date: Date, galaxy: Galaxy) -> Date {
        let myUnits = Int(self.distanceTraveled(date: date, galaxy: galaxy))
        let nextNumber : Int
        nextNumber = Int(Double(nextNumZeroes2(x: myUnits).0) / units(galaxy: galaxy).0)
        let futureDate = futureDateAdjusted(date: date, nextNumber: nextNumber)
        return futureDate
    }
    
    func futureDateString(date: Date, galaxy: Galaxy) ->  String {
        let futureDate = self.futureDate(date: date, galaxy: galaxy)
        let myFormatter = DateFormatter()
        myFormatter.dateStyle = .long
        myFormatter.timeStyle = .medium
        return myFormatter.string(from: futureDate)
    }
    
    func futureTextLabel (date: Date, galaxy: Galaxy) -> String {
        let formattedNumber = futureNumberString(date: date, galaxy: galaxy)
        let futureDate = self.futureDateString(date: date, galaxy: galaxy)
        var label = self.units(galaxy: galaxy).label
        if galaxy == .plancktime {
            label = "Planck Lengths"
        }
        if galaxy == .neutrinos {
            label = "Neutrinos"
        }
        return " will reach \(formattedNumber)\(suffix(galaxy:galaxy)) \(label) on \(futureDate)."
    }
    
    func futureCalendarLabel(date: Date, galaxy: Galaxy) -> String {
        let formattedNumber = futureNumberString(date: date, galaxy: galaxy)
        let label = self.units(galaxy: galaxy).label
        return " turns \(formattedNumber)\(suffix(galaxy:galaxy)) \(label)"
    }
}
