//
//  ChooseClockViewController.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 2/3/18.
//  Copyright © 2018 Corey Wade. All rights reserved.
//

import UIKit

class ChooseClockViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    //constraints are active to set up animation
    @IBOutlet weak var goButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var goButtonCenterConstraint: NSLayoutConstraint!
    
    //active outlets
    @IBOutlet weak var clockPicker: UIPickerView!
    @IBOutlet weak var unitsPicker: UIPickerView!
    @IBOutlet weak var goButton: UIButton!
    
    //Make sure to change these! Units are in quotes to eliminate ellipses on pickers
    var clocks = ["Standard", "Planets", "Exoplanets", "Galaxy", "Fun", "Motion", "Chemistry", "Human", "Relativity", "Classic"]
    var standardArray = ["Seconds", "Minutes", "Hours", "Days", "Weeks", "Months", "Years", "Age"]
    var planetArray = ["Mercury", "Venus", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto"]
    var exoplanetArray =  ["PSR J1719-1438 b", "WASP-12b", "SWEEPS-11", "HD 1189733 b", "TrES-2b", "Osiris", "51 Pegasi b", "Proxima Centauri b", "Kepler-37b", "Gliese 876 b", "Kepler-186f", "Kepler-16b", "HD 20782 b", "Gamma Cephei Ab", "Taphao Thong", "14 Her B", "OGLE-2005-BLG-390Lb", "Methuselah", "2MASS J21265040−8140293"]
    var galacticArray = ["Neutrinos", "Solar Miles", "Milkyway Miles", "Universe Miles", "Photon Circumnavigations", "Photon Kilometers", "Planck Time", "Black Hole NGC 1365", "Milli-sieverts of Radiation"]
    var sportsArray = ["100 Meter Dash", "50m Freestyle", "Mile World Record", "15m Climbing Record", "Skiing Speed", "Skating Speed", "Cheetah Speed", "Peregrine Falcon", "Black Marlin", "Mexican Free-tailed Bat"]
    var funArray = ["Average Hair Growth", "Jiffies", "Diracs", "Mileways", "Cicada Breeding Cycles", "Fallen Snowflakes" ]
    var halflifeArray = ["Oxygen-12", "Francium 223", "Gold-198", "Tritium", "Carbon-14", "Uranium-234", "Potassium-40", "Barium-130", "Tellerium 128"]
    var humanArray = ["Heart Beats", "Breaths", "Red Blood Cell Circulations", "Skin Regenerations", "Cumulative Red Blood Cells", "Blood Cell Lifetimes", "Neurons Cumulatively Fired", "Body Atoms"]
    var lightSpeedArray = ["10% Light Speed", "50% Light Speed", "75% Light Speed", "90% Light Speed", "99% Light Speed", "99.9% Light Speed", "99.99% Light Speed", "99.999% Light Speed"]
    var classicalArray = ["Fortnights", "Olympiads", "Lustrums", "Decades", "Indictions", "Centuries", "Millenia"]
    var unitsChosen = ["Seconds", "Minutes", "Hours", "Days", "Weeks", "Months", "Years", "Age"]
    
    //default values for switches with pickers working together
    var c = 0, y = 0
    
    //not sure these are being used
    var pickerWidth = 300
    var pickerHeight = 200
    
    //random large number to provide apparent endless scrolling
    let pickerViewRows = 1000
    
    //starting value for middle of picker
    var row = 500

    //boolean to distinguish between unit picker that has not been moved and unit picker that has been moved
    var unitsPickerMoved = false
    
    //base units for pickers
    var unit = Calendar.Component.second
    var planet = Planet(rawValue: 0)!
    var exoplanet = Exoplanet(rawValue: 0)!
    var galaxy = Galaxy(rawValue: 0)!
    var fun = Fun(rawValue: 0)!
    var sport = Sport(rawValue: 0)!
    var lightSpeed = LightSpeed(rawValue: 0)!
    var classical  = Classical(rawValue: 0)!
    var human = Human(rawValue: 0)!
    var halflife = Halflife(rawValue: 0)!
    
    //establish middle of picker as starting point
    private func pickerViewMiddle(pickerArray: Array<String>) -> Int {
        return pickerViewRows / 2
    }
    
    //set up customizable pickers
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: (CGRect(x: 0, y: 0, width: pickerWidth, height: pickerHeight)))
        let label = UILabel(frame: (CGRect(x: 0, y: 0, width: pickerWidth, height: pickerHeight)))
        label.textColor = .white
        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        if pickerView == clockPicker {
            label.text = clocks[row % clocks.count]
        }
        else {
            label.text = unitsChosen[row % unitsChosen.count]
        }
        view.addSubview(label)
        return view
    }
    
    //each picker shows only one component at a time
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //displays title of picker from above arrays
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case clockPicker : return clocks[row % clocks.count]
        case unitsPicker : return unitsChosen[row % unitsChosen.count]
        default: return "0"
        }
    }
    
    //set total number of picker rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewRows
    }
    
    //determines action when picker selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == clockPicker {
           //preslect value to switch unitsPicker depending upon which clockPicker selected
            c = row % clocks.count
            switch c {
            case 1 : unitsChosen = planetArray
                //displays correct unitsPicker after selecting clockPicker
                unitsPicker.reloadAllComponents()
            case 2 : unitsChosen = exoplanetArray
                unitsPicker.reloadAllComponents()
            case 3 : unitsChosen = galacticArray
                unitsPicker.reloadAllComponents()
            case 4 : unitsChosen = funArray
            unitsPicker.reloadAllComponents()
            case 5 : unitsChosen = sportsArray
            unitsPicker.reloadAllComponents()
            case 6 : unitsChosen = halflifeArray
            unitsPicker.reloadAllComponents()
            case 7 : unitsChosen = humanArray
            unitsPicker.reloadAllComponents()
            case 8 : unitsChosen = lightSpeedArray
            unitsPicker.reloadAllComponents()
            case 9 : unitsChosen = classicalArray
            unitsPicker.reloadAllComponents()
            default: unitsChosen = standardArray
            unitsPicker.reloadAllComponents()
            }
        }
            
        //access correct value on unitsPicker
        else if pickerView == unitsPicker {
            y = row % unitsChosen.count
            if unitsChosen == standardArray {
                unit = calendarCall(s: y)
            }
            else if unitsChosen == planetArray {
                planet = Planet(rawValue: y)!
            }
            else if unitsChosen == exoplanetArray {
                exoplanet = Exoplanet(rawValue: y)!
            }
            else if unitsChosen == galacticArray {
                galaxy = Galaxy(rawValue: y)!
            }
            else if unitsChosen == funArray {
                fun = Fun(rawValue: y)!
            }
            else if unitsChosen == sportsArray {
                sport = Sport(rawValue: y)!
            }
            else if unitsChosen == halflifeArray{
                halflife =  Halflife(rawValue: y)!
                }
            else if unitsChosen == humanArray{
                human =  Human(rawValue: y)!
                }
            else if unitsChosen == lightSpeedArray {
                lightSpeed =  LightSpeed(rawValue: y)!
                }
            else if unitsChosen == classicalArray {
                classical =  Classical(rawValue: y)!
                }
            else {
                ()
            }
            unitsPickerMoved = true
        }
    }
    
    @IBAction func goButton(_ sender: UIButton) {
        shouldPerformSegue(withIdentifier: "go", sender: self)
        //needed to ensure default unitsPicker value is selected if user does not move wheel
        if unitsPickerMoved == false {
            selectDefaultRowUnitsPicker()
        }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "go" {
            let segueController = segue.destination as! UINavigationController
            let targetController = segueController.topViewController as! MasterViewController
            targetController.c = c
            UserDefaults.standard.set(c, forKey: "currentClock")
            UserDefaults.standard.set(y, forKey: "currentUnit")
            switch c {
            case 1 : targetController.planet = planet
            case 2 : targetController.exoplanet = exoplanet
            case 3 : targetController.galaxy = galaxy
            case 4 : targetController.fun = fun
            case 5 : targetController.sport = sport
            case 6 : targetController.halflife = halflife
            case 7 : targetController.human = human
            case 8 : targetController.lightSpeed = lightSpeed
            case 9 : targetController.classical = classical
            default: targetController.unit = unit
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //shows Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        //eliminates backBar title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        //makes goButton Circle
        goButton.layer.cornerRadius = goButton.frame.size.width / 2
       
        //pushes goButton off screen for delayed animation
        goButtonBottomConstraint.constant += view.bounds.height / 2
        goButtonCenterConstraint.constant -= view.bounds.width
        
        //ensures that highlighted clockPicker row is selected without moving picker
        self.clockPicker.selectRow(pickerViewMiddle(pickerArray : clocks), inComponent: 0, animated: false)
        c = row % clocks.count
        switch c {
        case 1 : unitsChosen = planetArray
        unitsPicker.reloadAllComponents()
        case 2 : unitsChosen = exoplanetArray
        unitsPicker.reloadAllComponents()
        case 3 : unitsChosen = galacticArray
        unitsPicker.reloadAllComponents()
        case 4 : unitsChosen = funArray
        unitsPicker.reloadAllComponents()
        case 5 : unitsChosen = sportsArray
        unitsPicker.reloadAllComponents()
        case 6 : unitsChosen = halflifeArray
        unitsPicker.reloadAllComponents()
        case 7 : unitsChosen = humanArray
        unitsPicker.reloadAllComponents()
        case 8 : unitsChosen = lightSpeedArray
        unitsPicker.reloadAllComponents()
        case 9 : unitsChosen = classicalArray
        unitsPicker.reloadAllComponents()
        default: unitsChosen = standardArray
        }
        
        //ensures that highlighted unitsPicker row is selected without moving picker
        selectDefaultRowUnitsPicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.4, delay: 0.1, options: .curveEaseOut, animations: {
            self.goButtonCenterConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 1.05, delay: 0.0, options: .curveEaseInOut, animations: {
            self.goButtonBottomConstraint.constant -= self.view.bounds.height / 2
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //preslects default row on unitsPicker without user action
    func selectDefaultRowUnitsPicker() {
        self.unitsPicker.selectRow(pickerViewMiddle(pickerArray : standardArray), inComponent: 0, animated: false)
        y = row % unitsChosen.count
        if unitsChosen == standardArray {
            unit = calendarCall(s: y)
        }
        else if unitsChosen == planetArray {
            planet = Planet(rawValue: y)!
        }
        else if unitsChosen == exoplanetArray {
            exoplanet = Exoplanet(rawValue: y)!
        }
        else if unitsChosen == galacticArray {
            galaxy = Galaxy(rawValue: y)!
        }
        else if unitsChosen == funArray {
            fun = Fun(rawValue: y)!
        }
        else if unitsChosen == sportsArray {
            sport = Sport(rawValue: y)!
        }
        else if unitsChosen == halflifeArray{
            halflife =  Halflife(rawValue: y)!
        }
        else if unitsChosen == humanArray{
            human =  Human(rawValue: y)!
        }
        else if unitsChosen == lightSpeedArray {
            lightSpeed =  LightSpeed(rawValue: y)!
        }
        else if unitsChosen == classicalArray {
            classical =  Classical(rawValue: y)!
        }
        else {
            ()
        }
    }
    
}

