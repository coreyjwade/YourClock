//
//  gestureFunctions.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 1/27/18.
//  Copyright © 2018 Corey Wade. All rights reserved.
//

import Foundation
import EventKit
import EventKitUI

var unit = Calendar.Component.second

func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
    let eventStore = EKEventStore()
    
    eventStore.requestAccess(to: .event, completion: { (granted, error) in
        if (granted) && (error == nil) {
            let event = EKEvent(eventStore: eventStore)
            event.title = title
            event.startDate = startDate
            event.endDate = endDate
            event.notes = description
            event.calendar = eventStore.defaultCalendarForNewEvents
            do {
                try eventStore.save(event, span: .thisEvent)
            } catch let e as NSError {
                completion?(false, e)
                return
            }
            completion?(true, nil)
        } else {
            completion?(false, error as NSError?)
        }
    })
}

func calendarCall(s: Int) -> Calendar.Component {
    switch s % 8 {
    case 1: unit = Calendar.Component.minute
    case 2: unit = Calendar.Component.hour
    case 3: unit = Calendar.Component.day
    case 4: unit = Calendar.Component.weekOfYear
    case 5: unit = Calendar.Component.month
    case 6: unit = Calendar.Component.year
    //case 7 is computed differently: see updateTimer
    default: unit = Calendar.Component.second
    }
    return unit
}

var greeting = ["Wonderful happens. ", "Did you know? ", "It's real. ", "Capture time. ", "Believe it. ", "Congrats! Congrats! ", "Let it be known. ", "Mark the Calendar. ", "Lizards are leaping. ", "Take a breather. ", "Awesome Asterik: ",  "A moment to remember. ", "Parallel universes agree. ", "How sweet it is. ", "Commendations are rightfully deserved. ", "The universe has weighed in. ", "This electromagnetic wave declares: ", "What a tick. ", "It's not relative. ", "Time travels on. ", "Lock in. ", "Catch the ray. ", "Tock on. ", "Count this. ", "Stars are sparkling. ", "Spacetime is in accord. ", "Celebrate this. ", "Pulse on. "]

func randomGreeting() -> String {
    let randomChoice = Int(arc4random_uniform(UInt32(greeting.count)))
    return greeting[randomChoice]
}

//var timeThoughts = ["Time is relative.", "Space bends time.", "Time contains irrationals.", "Time is one with space.", "What happened before time?", "There is no time like time.", "The universe birthed time.", "Only light evades time.", "Can time be possessed?", "Who broke the arrow of time?", "Have you caught time?"]

//func randomTimeThought() -> String {
//    let randomChoice = Int(arc4random_uniform(UInt32(timeThoughts.count)))
//    return timeThoughts[randomChoice]
//}



