//
//  ViewController.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 7/27/17.
//  Copyright © 2017 Corey Wade. All rights reserved.
//

import UIKit
//import WatchConnectivity
//add WCSessionDelegate to class list below

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var buttonReadyToAnimate = true
    var userArray : Array<String>!
    var primaryLabel = "Your Clock"
    var birthDate = DateComponents()
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var secondsPicker: UIPickerView!
    var textBoxActivated = false
    var pickerSelected = false
    
    var secondsArray = [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59]
    var secondsLabel = "sec"
    var pickerWidth = 150
    var pickerHeight = 100
    let pickerViewRows = 1200
    var myIndex = 0
    var scomponents = 0
    
    private func pickerViewMiddle(userArray: Array<String>) -> Int {
        return pickerViewRows / 2
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: (CGRect(x: 0, y: 0, width: pickerWidth, height: pickerHeight)))
        let label = UILabel(frame: (CGRect(x: 0, y: 0, width: pickerWidth, height: pickerHeight)))
        label.textColor = .white
        label.textAlignment = .center
        //        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        if component == 1 {
            label.text = secondsLabel
        }
        else {
            label.text = String(secondsArray[row % secondsArray.count])
        }
        view.addSubview(label)
        return view
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 1 {
            return secondsLabel
        }
        else {
         return String(secondsArray[row % secondsArray.count])
        }
        }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            return 1
        }
        else {
         return pickerViewRows
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Changes the go button from accessing preloaded dates to one selected by the user
        pickerSelected = true
        
        if component == 0 {
         scomponents = row % secondsArray.count
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
            self.secondsPicker.selectRow(pickerViewMiddle(userArray: [String(describing: secondsArray)]), inComponent: 0, animated: false)
    }
    
    @IBAction func writeText(_ sender: UITextField) {
        if let option = textField.text {
            primaryLabel = option
            textBoxActivated = true
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        //Changes the go button from accessing preloaded dates to one selected by the user
        pickerSelected = true
    }
    
    @objc func timePickerValueChanged(_ sender: UIDatePicker){
        //Changes the go button from accessing preloaded dates to one selected by the user
        pickerSelected = true
    }
    
    
    @IBAction func goButton(_ sender: UIButton) {
        
        //"Your Clock" "Your Clock 1" Your Clock 2" results when user does not provide text input for selected date
        if textBoxActivated == false  && pickerSelected {
            let index = noNameArray.count
            primaryLabel = noNameArray[index-1]
            noNameArray.append("Your Clock \(index+1)")
        }
        
        //if a picker has not been selected, a random preloaded date will load
        if pickerSelected {
            
            //convert components from time picker and date picker into unified date
            let components = Calendar.current.dateComponents([.year, .month, .day], from: datePicker.date)
            let tcomponents = Calendar.current.dateComponents([.hour, .minute], from: timePicker.date)
            birthDate.year = components.year
            birthDate.month = components.month
            birthDate.day = components.day
            birthDate.hour = tcomponents.hour
            birthDate.minute = tcomponents.minute
            birthDate.second = scomponents
            //birthDay relays the provided date from the user
            let birthDay = Calendar.current.date(from: birthDate)!
            
            //stores user name for provided date
            UserDefaults.standard.set(primaryLabel, forKey: "userLabel")
            
            //places user name and provided date in dictionary
            userDict[primaryLabel] = birthDay
            UserDefaults.standard.set(userDict, forKey: "userDict")
            
            //stores user name in array
            userArray.append(primaryLabel)
            UserDefaults.standard.set(userArray, forKey: "userArray")
        }
    }
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var goButtonCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var goButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        //targets detect user changing pickers to ensure using is attempting to choose date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: UIControlEvents.valueChanged)
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(_:)), for: UIControlEvents.valueChanged)

        if UserDefaults.standard.bool(forKey: "firstRun") {
            self.navigationController!.navigationBar.topItem!.title = "Enter Your Birth Date"
            navigationItem.hidesBackButton = true
            UserDefaults.standard.set(false, forKey: "firstRun")
        }
        
        super.viewDidLoad()
        buttonReadyToAnimate = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        goButton.layer.cornerRadius = goButton.frame.size.width / 2
    
        goButtonBottomConstraint.constant += view.bounds.height / 2
        goButtonCenterConstraint.constant += view.bounds.width
        
    self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        if let myArray = UserDefaults.standard.array(forKey: "userArray") {
            userArray = myArray as! [String]
        }
            if let myDict = UserDefaults.standard.dictionary(forKey: "userDict") {
                userDict = myDict as! [String: Date]
            }
        
        self.textField.delegate = self
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        timePicker.setValue(UIColor.white, forKeyPath: "textColor")

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
//        Watch Loads
//        let complication = UIBarButtonItem(title: "Complication", style: .plain, target: self, action: #selector(sendComplicationTapped))
//
//        let message = UIBarButtonItem(title: "Message", style: .plain, target: self, action: #selector(sendMessageTapped))
//
//        let appInfor = UIBarButtonItem(title: "Context", style: .plain, target: self, action: #selector(sendAppContextTapped))
//
//        let file = UIBarButtonItem(title: "File", style: .plain, target: self, action: #selector(sendFileTapped))

//        navigationItem.leftBarButtonItems = [complication, message, appInfor, file]

//        if WCSession.isSupported() {
//            let session = WCSession.default
//            session.delegate = self
//            session.activate()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if buttonReadyToAnimate {
        UIView.animate(withDuration: 1.4, delay: 0.1, options: .curveEaseOut, animations: {
            self.goButtonCenterConstraint.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 1.05, delay: 0.0, options: .curveEaseInOut, animations: {
            self.goButtonBottomConstraint.constant -= self.view.bounds.height / 2
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
        buttonReadyToAnimate = false
        textBoxActivated = false
        pickerSelected = false
        UserDefaults.standard.set(false, forKey: "PickerSelected")
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Funcs For watch app
//    @objc func sendMessageTapped(){
//        let session = WCSession.default
//        if session.activationState == .activated {
//            let myClock = UserDefaults.standard.integer(forKey: "currentClock")
//            let myUnits = UserDefaults.standard.integer(forKey: "currentUnit")
//            if let myDate = UserDefaults.standard.dictionary(forKey: "userDict") {
//                userDate = myDate[userLabel] as! Date
//            }
//            if let myLabel = UserDefaults.standard.string(forKey: "userLabel") {
//                userLabel = myLabel
//            }
//            session.transferUserInfo(["myDate": userDate , "myClock": myClock, "myUnits": myUnits, "myLabel":userLabel])
//        }
//    }

//    @objc func sendAppContextTapped(){
//    }
//
//    @objc func sendComplicationTapped() {
//
//    }
//
//    @objc func sendFileTapped () {
//
//    }

//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//        DispatchQueue.main.async {
//            if activationState == .activated {
//                if session.isWatchAppInstalled {
//                    print("Watch app is installed!")
//                }
//            }
//        }
//    }

//    func sessionDidBecomeInactive(_ session: WCSession) {
//
//    }
//
//    func sessionDidDeactivate(_ session: WCSession) {
//        WCSession.default.activate()
//    }
}

