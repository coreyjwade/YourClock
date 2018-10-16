//
//  InterfaceController.swift
//  TimeVentionWatch Extension
//
//  Created by Corey Wade on 1/10/18.
//  Copyright © 2018 Corey Wade. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var clockLabel: WKInterfaceLabel!
    @IBOutlet var unitsLabel: WKInterfaceLabel!
    @IBOutlet var clockTypeLabel: WKInterfaceLabel!
    
    var watchDate = Date()
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
//    @objc func sendMessageTapped(){
//        let session = WCSession.default
//        if session.activationState == .activated {
//            //            let data = ["text": "User info from iPhone"]
//            let watchDict = userDict
//            session.transferUserInfo(watchDict)
//        }
//    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        DispatchQueue.main.async {
            if let watchLabel = userInfo["myLabel"] as? String {
                self.clockTypeLabel.setText(watchLabel)
            }
            if let watchUnits = userInfo["myUnits"] as? String {
                self.unitsLabel.setText(watchUnits)
            }
//            if let watchLabel = userInfo["myDate"] as? Date {
//                self.clockTypeLabel.setText(watchLabel)
//            }
        }

        
    }
    
}
