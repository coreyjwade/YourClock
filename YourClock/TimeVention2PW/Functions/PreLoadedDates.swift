//
//  Dates.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 1/3/18.
//  Copyright © 2018 Corey Wade. All rights reserved.
//

import Foundation

let myFormatter = DateFormatter()

func addDates (_ string : String) -> Date {
    myFormatter.dateFormat = "yyyy/MM/dd"
    if let date = myFormatter.date(from: string) {
      return date
    }
    else {
        return Date()
    }
}

//Define array that will contain all preloaded dates as tuple
var startDates : [(date: Date, label: String)] = [(addDates("1822/06/14"), "Mechanical Computer")]

//Helper func makes it easier to add dates
func pop(date: String, event: String) -> () {
    return startDates.append((addDates(date), event))
}

//Add new dates to array
func populateStartDates() {
    startDates.append((addDates("1946/02/15"), "Digital Computer"))
//    startDates.append((addDates("1964/04/22"), "Desktop Computer"))
    startDates.append((addDates("1991/08/06"), "World Wide Web"))
    startDates.append((addDates("1994/08/16"), "Smart Phone"))
//    startDates.append((addDates("1976/07/11"), "First Apple Computer"))
//    pop(date: "2000/01/01", event: "Millenium")
//    pop(date: "-4540000000/07/17", event: "Birth of Earth")
//    pop(date: "2015/03/14", event: "Pi Day of the Century")
    pop(date:"1964/01/26", event: "Silicon Transistor")
//    pop(date: "1969/07/20", event: "Moon Landing")
    pop(date: "1250/01/01", event: "Mechanical Clock") //exact date needed
    pop(date: "1657/01/01", event: "Pendulum Clock") //exact date needed
    pop(date: "1815/01/01", event: "Electric Clock") //exact date needed
    pop(date: "1955/01/01", event: "Atomic Clock") //exact date needed
//    pop(date: "2007/01/09", event: "iPhone") //more precise
    
    for entry in startDates {
        userArray.append(entry.label)
        userDict[entry.label] = entry.date
    }
    
    UserDefaults.standard.set(userArray, forKey: "userArray")
    UserDefaults.standard.set(userDict, forKey: "userDict")

    let primaryLabel = userArray[Int(arc4random_uniform(UInt32(userArray.count)-1))]
    UserDefaults.standard.set(primaryLabel, forKey: "userLabel")
    
    UserDefaults.standard.synchronize()
    
}



