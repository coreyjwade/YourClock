//
//  ChooseDateViewController.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 2/5/18.
//  Copyright © 2018 Corey Wade. All rights reserved.
//

import UIKit

var userDict = ["First Launch" : Date()]
var userLabel = "Your Clock"
var userDate = Date()
var userArray = ["First Launch"]
var noNameArray = ["Your Clock"]

class ChooseDateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var buttonReadyToAnimate = true
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var goButtonCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var goButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var myDatesPicker: UIPickerView!
    var myIndex = 0
    var pickerWidth = 300
    var pickerHeight = 200
    let pickerViewRows = 1000
    var row = 500
    
    private func pickerViewMiddle(userArray: Array<String>) -> Int {
        //this ensures the users last entered date is the first available option
        // the -1 accounts for titleForRow starting at index 0
//        return userArray.count - ((pickerViewRows / 2) % userArray.count) + (pickerViewRows / 2) - 1

        if let userLabelIndex = userArray.index(of: userLabel) {
            let myIndex = userLabelIndex
            return ((pickerViewRows/2)/userArray.count)*userArray.count + myIndex
        }
        else {
            //this is the last entry
            return userArray.count - ((pickerViewRows / 2) % userArray.count) + (pickerViewRows / 2) - 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: (CGRect(x: 0, y: 0, width: pickerWidth, height: pickerHeight)))
        let label = UILabel(frame: (CGRect(x: 0, y: 0, width: pickerWidth, height: pickerHeight)))
        label.textColor = .white
        label.textAlignment = .center
        //        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        label.text = userArray[row % userArray.count]
        view.addSubview(label)
        return view
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userArray[row % userArray.count]
        }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewRows
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myIndex = row % userArray.count
        UserDefaults.standard.set(userArray[myIndex], forKey: "userLabel")
        }
    
    @IBAction func deleteButton(_ sender: UIBarButtonItem) {
       
        var text = "We're having trouble with your request..."
        let header = "Delete Date"
        if let dateToDelete = userArray[safe: myIndex] {
            text = "Are you sure you want to delete \(dateToDelete)?"
        }

        let alert=UIAlertController(title: header, message: text, preferredStyle: UIAlertControllerStyle.alert);
        
        //no event handler (just close dialog box)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil));
        
        //event handler with closure
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
            userArray.remove(at: self.myIndex)
            UserDefaults.standard.set(userArray, forKey: "userArray")
            if let myArray = UserDefaults.standard.array(forKey: "userArray") {
                userArray = myArray as! [String]
                self.myDatesPicker.reloadAllComponents()
            }
        }))
        
        present(alert, animated: true, completion: nil);
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func viewDidLoad() {
        
        buttonReadyToAnimate = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        goButton.layer.cornerRadius = goButton.frame.size.width / 2
        super.viewDidLoad()
        
        goButtonBottomConstraint.constant += view.bounds.height / 2
        goButtonCenterConstraint.constant += view.bounds.width

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
            if let myArray = UserDefaults.standard.array(forKey: "userArray") {
                userArray = myArray as! [String]
            }
        }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.myDatesPicker.selectRow(pickerViewMiddle(userArray : userArray), inComponent: 0, animated: false)
        let row = userArray.count - ((pickerViewRows / 2) % userArray.count) + (pickerViewRows / 2) - 1
        myIndex = row % userArray.count
        UserDefaults.standard.set(userArray[myIndex], forKey: "userLabel")
        
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
    }
    
    
    

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
}

extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
