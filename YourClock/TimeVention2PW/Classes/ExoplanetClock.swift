//
//  ExoplanetClock.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 12/21/17.
//  Copyright © 2017 Corey Wade. All rights reserved.
//

import Foundation

enum Exoplanet : Int, CaseCountable {
    case pSRJ17191438b, wasp12b, sweeps11, hd1189733b, tres2b, hD209458b, pegasi51b, proximaCentaurib, kepler37b, gliese876b, kepler186f, kepler16b, hd20782b, gammaCepheiAb, taphaoThong, _14herb, oGLE2005BLG390Lb, pSRB162026b, mASSJ212650408140293
}

class ExoplanetClock: Clock {
    override init(date: Date) {
        super.init(date: date)
    }
    
    let name = "Exoplanets"
    
//Planet Orbits in Number of Seconds
func units (exoplanet: Exoplanet) -> (orbit: Double, label: String, decimalPlaces: Int){
    var orbit: (Double, String, Int)
    switch exoplanet {
    case .wasp12b: orbit = (0.00299630754*yearSecs, "WASP-12b", 6)
    case .sweeps11: orbit = (0.00493059826*yearSecs, "SWEEPS-11", 7)
    case .hd1189733b: orbit = (0.00607402287*yearSecs, "HD 1189733 b", 7)
    case .tres2b: orbit = (0.00676238035*yearSecs, "TrES-2b", 7)
    case .hD209458b: orbit = (0.00967656103*yearSecs, "Osiris", 7)
    case .pegasi51b: orbit = (0.01166761837*yearSecs, "51 Pegasi b", 7)
    case .proximaCentaurib: orbit = (0.03060866898*yearSecs, "Proxima Centauri b", 7)
    case .kepler37b: orbit = (0.03568918562*yearSecs, "Kepler-37b", 7)
    case .gliese876b: orbit = (0.16732538274*yearSecs, "Gliese 876 b", 8)
    case .kepler186f: orbit = (0.35*yearSecs, "Kepler-186f", 8)
    case .kepler16b: orbit = (0.62867873144*yearSecs, "Kepler-16b", 9)
    case .hd20782b: orbit = (1.60837433014*yearSecs, "HD 20782 b", 9)
    case .gammaCepheiAb: orbit = (2.472*31536000, "Gamma Cephei Ab", 9)
    case .taphaoThong: orbit = (2.95135466632*31356000, "Taphao Thong", 9)
    case ._14herb: orbit = (4.85*31536000, "14 Her B", 10)
    case .oGLE2005BLG390Lb: orbit = (9.58232034518*31356000, "OGLE-2005-BLG-390Lb", 10)
    case .pSRB162026b: orbit = (99.9983573165*31356000,  "Methuselah", 11)
    case .mASSJ212650408140293: orbit = (900000*yearSecs, "2MASS J21265040−8140293", 15)
    case .pSRJ17191438b: orbit = (2.2*3600, "PSR J1719-1438 b", 5)
    }
    return orbit
}

    func additionalLabel(exoplanet: Exoplanet) -> String {
        var label: String
        switch exoplanet {
        case .sweeps11: label = "SWEEPS-11 is the furthest exoplanet from Earth at 27,710 light years away."
        case .kepler186f: label = "Kepler-186f was the first Earth-sized exoplanet discovered in the habitable zone in 2014."
        case .kepler16b: label = "Kepler-16b was the first exoplanet discovered with an unambiguous circumbinary orbit."
        case .kepler37b: label = "Barely larger than the moon, Kepler-37b is the smallest exoplanet orbiting a main sequence star."
        case .hd20782b: label = "HD 20782 b has the most eccentric orbit of any planet with eccentricity e = 0.97."
        case .wasp12b: label = "WASP-12 b is the first exoplanet to be observed being consumed by its host star."
        case ._14herb: label = "14 Her B had the longest known orbit of any exoplanet upon discovery in the 90s."
        case .pegasi51b: label = "On October 6, 1995, Michael Mayor discovered 51 Pegasi b, the first exoplanet."
        case .hD209458b: label = "Osiris was the first exoplanet observed transiting across its host star in 1999."
        case .pSRJ17191438b: label = "PSR J1719-1438 b has the shortest known planetary orbit at 2.2 hours."
        case .proximaCentaurib: label = "Proxima Centauri b is the closest exoplanet to Earth at 4.2 light years away."
        case .hd1189733b: label = "HD 189733 b was the first exoplanet to have its overall color, deep blue, determined."
        case .tres2b: label = "Darker than coal, TrES-2b reflects less than 1% of its light."
        case .oGLE2005BLG390Lb: label = "Known as Hoth, OGLE-2005-BLG-390Lb is one of the furthest expolanets from Earth at 21,500 light years away."
        case .gammaCepheiAb: label = "Gamma Cephei Ab was the first suspected exoplanet in 1988, but it was not confirmed until 2002."
        case .taphaoThong: label = "In 1996, Taphao Thong was the first exoplanet discovered with a 'long period' orbiting a main sequence star."
        case .gliese876b: label = "Gliese 876 b was the first exoplanet discovered orbiting a red dwarf in 1998."
        case .pSRB162026b: label = "At 12.7 billion years old, PSR B1620-26 b, also known as 'the Genesis Planet,' was the first planet discovered orbiting two stars."
        case .mASSJ212650408140293: label = "2MASS J21265040−8140293 has the longest known orbit of any planet at nearly 900,000 years."
        }
        return label
    }
    
    private func ageOnPlanet(date: Date, exoplanet: Exoplanet) -> Double {
        let earthSeconds = totalSeconds(date: date)
        let planetOrbit = units(exoplanet: exoplanet).orbit
        return earthSeconds/planetOrbit
    }
    
    func futureNumber(date: Date, exoplanet: Exoplanet) -> Int{
        let units = Int(self.ageOnPlanet(date: date, exoplanet: exoplanet))
        let nextNumber : Int
        nextNumber = nextNumZeroes2(x: units).0
        return nextNumber
    }
    
    func futureNumberString(date: Date, exoplanet: Exoplanet) -> String {
        let nextNumber = futureNumber(date: date, exoplanet: exoplanet)
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        let formattedNumber = numberFormatter.string(from: NSNumber(value:nextNumber))
        return formattedNumber!
    }
    
    func futureDate(date: Date, exoplanet: Exoplanet) -> Date {
        let myUnits = Int(self.ageOnPlanet(date: date, exoplanet: exoplanet))
        let nextNumber : Int
        nextNumber = nextNumZeroes2(x: myUnits).0 * Int(units(exoplanet: exoplanet).0)
        let futureDate  = futureDateAdjusted(date: date, nextNumber: nextNumber)
        return futureDate
    }
    
    func futureDateString(date: Date, exoplanet: Exoplanet) ->  String {
        let futureDate = self.futureDate(date: date, exoplanet: exoplanet)
        let myFormatter = DateFormatter()
        myFormatter.dateStyle = .long
        myFormatter.timeStyle = .medium
        return myFormatter.string(from: futureDate)
    }
    
    func futureTextLabel (date: Date, exoplanet: Exoplanet) -> String {
        let formattedNumber = futureNumberString(date: date, exoplanet: exoplanet)
        let futureDate = self.futureDateString(date: date, exoplanet: exoplanet)
        let label = self.units(exoplanet: exoplanet).label
        return " will turn \(formattedNumber) on \(label) on \(futureDate)."
    }
    
    func futureCalendarLabel(date: Date, exoplanet: Exoplanet) -> String {
        let formattedNumber = futureNumberString(date: date, exoplanet: exoplanet)
        let label = self.units(exoplanet: exoplanet).label
        return " turns \(formattedNumber) on \(label)"
    }
    
    func label(exoplanet: Exoplanet) -> String {
        let prefix = "Age on "
        let main = units(exoplanet: exoplanet).label
        return prefix + main
    }
    
    func numberFormatterYears (date: Date, exoplanet: Exoplanet) -> String {
        numberFormatter.maximumFractionDigits = units(exoplanet: exoplanet).decimalPlaces
        numberFormatter.minimumFractionDigits = units(exoplanet: exoplanet).decimalPlaces
        let display = numberFormatter.string(from: NSNumber(value: ageOnPlanet(date: date, exoplanet: exoplanet)))
        return display!
    }
    
//    func futureLabel (date: Date, exoplanet: Exoplanet) -> String {
//        let units = Int(self.ageOnPlanet(date: date, exoplanet: exoplanet))
//        let nextNumber : Int
//        nextNumber = nextNumZeroes2(x: units).0
//        numberFormatter.maximumFractionDigits = 0
//        numberFormatter.minimumFractionDigits = 0
//        let formattedNumber = numberFormatter.string(from: NSNumber(value:nextNumber))
//        var futureDate = self.futureDate(date: date, exoplanet: exoplanet)
//        let label = self.units(exoplanet: exoplanet).label
//        return " will turn \(formattedNumber!) on \(label) on \(futureDate)."
//    }
//
//    func futureDate(date: Date, exoplanet: Exoplanet) -> String {
//        let myUnits = Int(self.ageOnPlanet(date: date, exoplanet: exoplanet))
//        let nextNumber : Int
//        nextNumber = nextNumZeroes2(x: myUnits).0 * Int(units(exoplanet: exoplanet).0)
//        var futureDate = userCalendar.date(byAdding: .second, value: nextNumber, to: date)
//        if checkOverflow(date: date){
//            futureDate = futureDateAdjusted(date: date, nextNumber: nextNumber)
//        }
//        let myFormatter = DateFormatter()
//        myFormatter.dateStyle = .medium
//        myFormatter.timeStyle = .medium
//        return myFormatter.string(from: futureDate!)
//    }
    
}
