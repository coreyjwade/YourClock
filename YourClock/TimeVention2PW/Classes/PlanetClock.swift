//
//  PlanetClock.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 12/21/17.
//  Copyright © 2017 Corey Wade. All rights reserved.
//

import Foundation

enum Planet : Int, CaseCountable {
    case mercury, venus, mars, jupiter, saturn, uranus, neptune, pluto
}

class PlanetClock: Clock {
    
    override init(date: Date) {
        super.init(date: date)
    }

    let name = "Planets"
    
func units (planet: Planet) -> (time: Double, label: String, decimalPlaces: Int) {
        var info: (Double, String, Int)
        switch planet {
        case .mercury: info = (87.9691*86400, "Mercury", 8)
        case .venus: info = (225*86400, "Venus", 8)
        case .mars: info = (1.881*365.25636*86400, "Mars", 8)
        case .jupiter: info = (11.886*365.25636*86400, "Jupiter", 9)
        case .saturn: info = (29.46*365.25636*86400, "Saturn", 9)
        case .uranus: info = (84.01*365.25636*86400, "Uranus", 10)
        case .neptune: info = (164.8*365.25636*86400, "Neptune", 10)
        case .pluto: info = (248.1*365.25636*86400, "Pluto", 10)
        }
        return info
    }
    
    // Converts to Age (in Years) on Planet
    private func ageOnPlanet (date: Date, planet: Planet) -> Double {
        let earthSeconds = self.totalSeconds(date: date)
        let planetOrbit = self.units(planet: planet).time
        return earthSeconds / planetOrbit
    }
    
    func numberFormatterYears (date: Date, planet: Planet) -> String {
        numberFormatter.maximumFractionDigits = self.units(planet: planet).decimalPlaces
        numberFormatter.minimumFractionDigits = self.units(planet: planet).decimalPlaces
        let display = numberFormatter.string(from: NSNumber(value: ageOnPlanet(date: date, planet: planet)))
        return display!
    }
    
    func label(planet: Planet) -> String {
        let prefix = "Age on "
        let main = self.units(planet: planet).label
        return prefix + main
    }
    
    // Planet Rotations in Seconds
    private func rotationUnits (planet: Planet) -> (rotation: Double, label: String, decimalPlaces: Int) {
        var info: (Double, String, Int)
        switch planet {
        case .mercury: info = (5068800, "Mercury", 8)
        case .venus: info = (20995200, "Venus", 10)
        case .mars: info = (90000, "Mars", 9)
        case .jupiter: info = (36000, "Jupiter", 7)
        case .saturn: info = (39600, "Saturn", 8)
        case .uranus: info = (61200, "Uranus", 8)
        case .neptune: info = (57600, "Neptune", 8)
        case .pluto: info = (550800, "Pluto", 9)
        }
        return info
    }
    
    func additionalLabel(planet: Planet) -> String {
        var label: String
        switch planet {
        case .mercury: label = "Deviations in the precession of Mercury's orbit could not be explained until the Theory of Relativity."
        case .venus: label = "Named after the Roman goddess of love, Venus is the second brightest object in the night sky."
        case .mars: label = "Named after the Roman god of war, Mars contains underground ice in the Utopia Planita region equivalent in volume to the size of Lake Superior."
        case .jupiter: label = "Jupiter is home to at least 69 moons, including the four Galilean moons, the first clestial objects discovered orbiting another planet."
        case .saturn: label = "Saturn's rings are full of ice particles, rocky debris, dust, and at least 62 moons."
        case .uranus: label = "Uranus is the only planet in our solar system whose axis of rotation is tilted sideways."
        case .neptune: label = "When deviations in the orbit of Uranus could not be accounted for by Newtonian Mechanis, mathematicians postulated a third body and discovered Neptune with pencil and paper."
        case .pluto: label = "Pluto was the smallest planet until it was demoted to dwarf planet status by the International Astronomical Union in 2006."
        }
        return label
    }
    
    func futureNumber(date: Date, planet: Planet) -> Int{
        let units = Int(self.ageOnPlanet(date: date, planet: planet))
        let nextNum : Int
//        nextNum = nextNumZeroes2(x: units).0
        nextNum = nextNumber(units: units)
        return nextNum
    }
    
    func futureNumberString(date: Date, planet: Planet) -> String {
        let nextNumber = futureNumber(date: date, planet: planet)
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        let formattedNumber = numberFormatter.string(from: NSNumber(value:nextNumber))
        return formattedNumber!
    }
    
    func futureDate(date: Date, planet: Planet) -> Date {
        let myUnits = Int(self.ageOnPlanet(date: date, planet: planet))
        let nextNum : Int
//        nextNum = nextNumZeroes2(x: myUnits).0 * Int(units(planet: planet).0)
        nextNum = nextNumber(units: myUnits) * Int(units(planet: planet).0)
        let futureDate = futureDateAdjusted(date: date, nextNumber: nextNum)
//        }
        return futureDate
    }
    
    func futureDateString(date: Date, planet: Planet) ->  String {
        let futureDate = self.futureDate(date: date, planet: planet)
        let myFormatter = DateFormatter()
        myFormatter.dateStyle = .long
        myFormatter.timeStyle = .medium
        return myFormatter.string(from: futureDate)
    }
    
    func futureTextLabel (date: Date, planet: Planet) -> String {
        let formattedNumber = futureNumberString(date: date, planet: planet)
        let futureDate = self.futureDateString(date: date, planet: planet)
        let label = self.units(planet: planet).label
        return " will turn \(formattedNumber) on \(label) on \(futureDate)."
    }
    
    func futureCalendarLabel(date: Date, planet: Planet) -> String {
        let formattedNumber = futureNumberString(date: date, planet: planet)
        let label = self.units(planet: planet).label
        return " turns \(formattedNumber) on \(label)"
    }
    
    
    private func daysOnPlanet (date: Date, planet: Planet) -> Double {
        let earthSeconds = self.totalSeconds(date: date)
        let planetRotations = rotationUnits(planet: planet).rotation
        return earthSeconds/planetRotations
    }
    
    func numberFormatterDays (date: Date, planet: Planet) -> String {
        numberFormatter.maximumFractionDigits = self.rotationUnits(planet: planet).decimalPlaces
        numberFormatter.minimumFractionDigits = self.rotationUnits(planet: planet).decimalPlaces
        let display = numberFormatter.string(from: NSNumber(value: daysOnPlanet(date: date, planet: planet)))
        return display!
    }
}
