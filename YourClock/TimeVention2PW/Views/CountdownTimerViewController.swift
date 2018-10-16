//
//  CountdownTimerViewController.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 3/12/18.
//  Copyright © 2018 Corey Wade. All rights reserved.
//

import UIKit

var countdownArray = ["WWW Billionth Second"]
var countdownDict = ["WWW Billionth Second": Date()]

class CountdownTimerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var countdownPicker: UIPickerView!
    var myIndex = 0
    var pickerWidth = 300
    var pickerHeight = 200
    let pickerViewRows = 1000
    var row = 500
    var countdown = false
    private func pickerViewMiddle(userArray: Array<String>) -> Int {
        return pickerViewRows / 2
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: (CGRect(x: 0, y: 0, width: pickerWidth, height: pickerHeight)))
        let label = UILabel(frame: (CGRect(x: 0, y: 0, width: pickerWidth, height: pickerHeight)))
        label.textColor = .white
        label.textAlignment = .center
        //        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        label.text = countdownArray[row % countdownArray.count]
        view.addSubview(label)
        return view
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countdownArray[row % countdownArray.count]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewRows
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myIndex = row % countdownArray.count
        UserDefaults.standard.set(countdownArray[myIndex], forKey: "countdownDate")
        countdown = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
