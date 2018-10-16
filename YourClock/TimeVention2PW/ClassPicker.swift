//
//  ClassPicker.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 1/7/18.
//  Copyright © 2018 Corey Wade. All rights reserved.
//

import UIKit

var myArray = ["Clock1", "Clock2", "Clock3"]
var selectedClock : String?

class ClassPicker: UIPickerView {
    var data : [Clock]!
}

//extension ClassPicker: UIPickerViewDataSource {
//
//    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return myArray.count
//    }
//}
//
//extension ClassPicker: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return myArray[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        selectedClock = myArray[row]
//    }
//}

