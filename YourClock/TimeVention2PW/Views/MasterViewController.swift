//
//  MasterViewContoller.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 12/19/17.
//  Copyright © 2017 Corey Wade. All rights reserved.
//

//crashalytics

import UIKit
import EventKit
import EventKitUI

class MasterViewController: UIViewController {
    
    //bottom constraint linked for animation
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
    //pivot button will hide when selected before all buttons display
    @IBOutlet weak var showOptionsButton: UIButton!
    //rectangulur view to be converted to circular view
    @IBOutlet weak var circularView: UIView!
    
    var bottomBarVisible = false
    var userArray = ["First Launch"]
    var NoNameArray = ["Your Clock"]
    //single variables corresponds to particular clocks to keep track of place when swiping / tapping forward
    var c = 0, s = 0, p = 0, e = 0, g = 0, f = 0, x = 0, z = 0, h = 0, l = 0, a = 0, t = 0
    var value = 0
    var userLabel = "Your Clock"
    var userDate = Date()
    //default variable for Standard Clock and App
    var unit = Calendar.Component.second
    
    //default start case for each enum
    //these vars determine which unit is on display
    var planet = Planet(rawValue: 0)!
    var exoplanet = Exoplanet(rawValue: 0)!
    var galaxy = Galaxy(rawValue: 0)!
    var fun = Fun(rawValue: 0)!
    var sport = Sport(rawValue: 0)!
    var lightSpeed = LightSpeed(rawValue: 0)!
    var classical  = Classical(rawValue: 0)!
    var human = Human(rawValue: 0)!
    var halflife = Halflife(rawValue: 0)!
    
    //instances of each clock
    var userClock: StandardClock!
    var userClock1: PlanetClock!
    var userClock2: ExoplanetClock!
    var userClock3: GalacticClock!
    var userClock4: FunClock!
    var userClock5: SportsClock!
    var userClock6: HalflifeClock!
    var userClock7: HumanClock!
    var userClock8: LightSpeedClock!
    var userClock9: ClassicalClock!
    
    @IBOutlet weak var label: UILabel! {
        //this stops the number display from jumping
        didSet {
            label.font = UIFont.monospacedDigitSystemFont(ofSize: label!.font!.pointSize, weight: UIFont.Weight.regular)
        }
    }
    
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var additionalLabel: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    //booleans are used to keep track of values for accurate back button
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        backSwipe()
        additionalLabel.rightToLeftAnimation()
    }
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        c+=1
        additionalLabel.leftToRightAnimation()
    }
    
    @IBAction func showOptionsButton(_ sender: Any) {
        buttonStackView.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
            self.stackViewBottomConstraint.constant = 8
            self.view.layoutIfNeeded()
        }, completion: nil)
        showOptionsButton.isHidden = true
        UserDefaults.standard.set(true, forKey:"BottomBarVisible")
    }
    
    @IBAction func upSwipe(_ sender: UISwipeGestureRecognizer) {
        buttonStackView.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
            self.stackViewBottomConstraint.constant = 8
            self.view.layoutIfNeeded()
            }, completion: nil)
        showOptionsButton.isHidden = true
        UserDefaults.standard.set(true, forKey:"BottomBarVisible")
    }
    
    @objc func hiddenTimer() {
        buttonStackView.isHidden = true
    }
    
    @IBAction func downSwipe(_ sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: {
            self.stackViewBottomConstraint.constant = -self.buttonStackView.bounds.height - 8
            self.view.layoutIfNeeded()
        }, completion: nil)
            showOptionsButton.isHidden = false
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(MasterViewController.hiddenTimer), userInfo: nil, repeats: false)
            UserDefaults.standard.set(false, forKey:"BottomBarVisible")
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        forwardTap()
    }
    
    @IBAction func cameraButton(_ sender: UIButton) {
        presentPhoto()
    }
    
    @IBAction func randomButton(_ sender: UIButton) {
        random()
    }
    
    @IBAction func shareButton(_ sender: Any) {
        shareText()
    }
    
    @IBAction func futureDatesButton(_ sender: UIButton) {
        futureDateControl()
    }
    
    @IBAction func funFactButton(_ sender: Any) {
        funFactAlert()
    }
    
    func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(userLabel, forKey: "userLabel")
        UserDefaults.standard.set(c, forKey: "currentClock")
        value = clockUnitSwitcher()
        UserDefaults.standard.set(value, forKey: "currentUnit")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up shake
        self.becomeFirstResponder()
        
        //load userDefaults
        if let myArray = UserDefaults.standard.array(forKey: "userArray") {
            userArray = myArray as! [String]
        }
        
        if let myLabel = UserDefaults.standard.string(forKey: "userLabel") {
            userLabel = myLabel
        }
            
        if let myDate = UserDefaults.standard.dictionary(forKey: "userDict") {
            userDate = myDate[userLabel] as! Date
            }
        
        //load all clocks
        secondaryLabel.text = userLabel
        userClock = StandardClock(date: userDate)
        userClock1 = PlanetClock(date: userDate)
        userClock2 = ExoplanetClock(date: userDate)
        userClock3 = GalacticClock(date: userDate)
        userClock4 = FunClock(date: userDate)
        userClock5 = SportsClock(date: userDate)
        userClock6 = HalflifeClock(date: userDate)
        userClock7 = HumanClock(date: userDate)
        userClock8 = LightSpeedClock(date: userDate)
        userClock9 = ClassicalClock(date: userDate)
        
        //load clock and units from last screen via userDefaults
        c = UserDefaults.standard.integer(forKey: "currentClock")
        value = UserDefaults.standard.integer(forKey: "currentUnit")
        
        //set appropriate clock and units for current run
        switch c % Clocks.caseCount {
        case 1: if let start = Planet(rawValue: value) {
            planet = start
            p = value
        }
        else {
            planet = Planet(rawValue: 0)!
        }
        case 2: if let start = Exoplanet(rawValue: value) {
            exoplanet = start
            e = value
        }
        else {
            exoplanet = Exoplanet(rawValue: 0)!
        }
        case 3: if let start = Galaxy(rawValue: value) {
            galaxy = start
            g = value
        }
        else {
            galaxy = Galaxy(rawValue: 0)!
        }
        case 4: if let start = Fun(rawValue: value) {
            fun = start
            f = value
        }
        else {
            fun = Fun(rawValue: 0)!
            }
        case 5: if let start = Sport(rawValue: value) {
            sport = start
            x = value
        }
        else {
            sport = Sport(rawValue: 0)!
        }
        case 6:if let start = Halflife(rawValue: value) {
            halflife = start
            z = value
        }
        else {
            halflife = Halflife(rawValue: 0)!
        }
        case 7: if let start = Human(rawValue: value) {
            human = start
            h = value
        }
        else {
            human = Human(rawValue: 0)!
            }
        case 8: if let start = LightSpeed(rawValue: value) {
            lightSpeed = start
             l = value
        }
        else {
            lightSpeed = LightSpeed(rawValue: 0)!
        }
        case 9: if let start = Classical(rawValue: value) {
            classical = start
            a = value
        }
        else {
            classical = Classical(rawValue: 0)!
            }
        default: unit = calendarCall(s: value)
            s = value
        }
        
        //call to update screen every tenth of a second
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(MasterViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    //core part of app that updates every tenth of a second
    @objc func updateTimer() {
        switch c % Clocks.caseCount {
        case 1: label.text = userClock1.numberFormatterYears(date: userDate, planet: planet);
        additionalLabel.text = userClock1.label(planet: planet)
        case 2: label.text = userClock2.numberFormatterYears(date: userDate, exoplanet: exoplanet);
        additionalLabel.text = userClock2.label(exoplanet: exoplanet)
        case 3: label.text = userClock3.numberFormatterYears(date: userDate, galaxy: galaxy)
        additionalLabel.text = userClock3.label(galaxy: galaxy)
        case 4: label.text = userClock4.numberFormatterYears(date: userDate, fun: fun)
        additionalLabel.text = userClock4.label(fun: fun)
        case 5: label.text = userClock5.numberFormatterYears(date: userDate, sport: sport);
        additionalLabel.text = userClock5.label(sport: sport)
        case 6: label.text = userClock6.numberFormatterYears(date: userDate, halflife: halflife);
        additionalLabel.text = userClock6.label(halflife: halflife)
        case 7: label.text = userClock7.numberFormatterYears(date: userDate, human: human);
        additionalLabel.text = userClock7.label(human: human)
        case 8: label.text = userClock8.numberFormatterYears(date: userDate, lightSpeed: lightSpeed);
        additionalLabel.text = userClock8.label(lightSpeed: lightSpeed, date: userDate)
        case 9: label.text = userClock9.numberFormatterYears(date: userDate, classical: classical);
        additionalLabel.text = userClock9.label(classical: classical, date: userDate)
        default : if s % 8 == userClock.count {
            label.text = userClock.diffClock(date: userDate)
            additionalLabel.text = "Your Clock"
            }
        else {
            label.text = userClock.numberFormatter(date: userDate, unit: unit);
            additionalLabel.text = userClock.label(unit: unit)
        }
    }
}
    
    //set up shake
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            random()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        if UserDefaults.standard.bool(forKey: "BottomBarVisible") == false {
            buttonStackView.isHidden = true
            stackViewBottomConstraint.constant = -buttonStackView.bounds.height - 8
            showOptionsButton.isHidden = false
        }
        else {
            showOptionsButton.isHidden = true
            buttonStackView.isHidden = false
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        circularView.frame.size.width =  view.bounds.width
        circularView.frame.size.height = circularView.frame.size.width
        circularView.layer.cornerRadius = circularView.frame.size.width / 2
    }
}


extension MasterViewController {
    
    //set value of clock at load time
    func clockUnitSwitcher() -> Int {
        var value: Int
        switch c % Clocks.caseCount {
        case 1: value = planet.rawValue
        case 2: value = exoplanet.rawValue
        case 3: value = galaxy.rawValue
        case 4: value = fun.rawValue
        case 5: value = sport.rawValue
        case 6: value = halflife.rawValue
        case 7: value = human.rawValue
        case 8: value = lightSpeed.rawValue
        case 9: value = classical.rawValue
        //standard clock does not have raw values
        default: value = s % 8
        }
        return value
    }
    
    func futureDateControl(){
        let user = secondaryLabel.text
        var textLabel: String
        var calendarLabel: String
        var futureCalendarDate = userClock.futureDate(date: userDate, unit: unit)
        let header = "Coming Soon"
        let compError = " Swift has entered a computational wormhole"
        switch c % Clocks.caseCount {
        case 0:
            if s == 7 {
                specialCase = true
            }
            textLabel = userClock.futureTextLabel(date: userDate, unit: unit)
            futureCalendarDate = userClock.futureDate(date: userDate, unit: unit)
            specialCase = false
        case 1: textLabel = userClock1.futureTextLabel(date: userDate, planet: planet)
            futureCalendarDate = userClock1.futureDate(date: userDate, planet: planet)
        case 2: textLabel = userClock2.futureTextLabel(date: userDate, exoplanet: exoplanet)
            futureCalendarDate = userClock2.futureDate(date: userDate, exoplanet: exoplanet)
        case 3: if galaxy == .plancktime {
            textLabel = compError
        }
        else {
            textLabel = userClock3.futureTextLabel(date: userDate, galaxy: galaxy)
        }
            futureCalendarDate = userClock3.futureDate(date: userDate, galaxy: galaxy)
        case 4: textLabel = userClock4.futureTextLabel(date: userDate, fun: fun)
            futureCalendarDate =  userClock4.futureDate(date: userDate, fun: fun)
        case 5: textLabel = userClock5.futureTextLabel(date: userDate, sport: sport)
            futureCalendarDate = userClock5.futureDate(date: userDate, sport: sport)
        case 6:
            if halflife == .barium || halflife == .tellurium128 || halflife == .potassium40 {
            textLabel = compError
            }
            else {
             textLabel = userClock6.futureTextLabel(date: userDate, halflife: halflife)
            }
            futureCalendarDate = userClock6.futureDate(date: userDate, halflife: halflife)
        case 7: textLabel = userClock7.futureTextLabel(date: userDate, human: human)
            futureCalendarDate = userClock7.futureDate(date: userDate, human: human)
        case 8: textLabel = userClock8.futureTextLabel(date: userDate, lightSpeed: lightSpeed)
            futureCalendarDate = userClock8.futureDate(date: userDate, lightSpeed: lightSpeed)
        case 9: textLabel = userClock9.futureTextLabel(date: userDate, classical: classical)
            futureCalendarDate = userClock9.futureDate(date: userDate, classical: classical)
        default: textLabel = "Time is relative."
        }
        
        textLabel = user! + textLabel
        
        let alert=UIAlertController(title: header, message: textLabel, preferredStyle: UIAlertControllerStyle.alert);
        
        //no event handler (just close dialog box)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: nil));
        
        //event handler with closure
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
            
            //This is a nested alert that provides a calendar export option
            let alert=UIAlertController(title: "Options", message: "Share with others, or export to calendar.", preferredStyle: UIAlertControllerStyle.alert);
            
            //event handler with closure
            alert.addAction(UIAlertAction(title: "Calendar", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
            
            //set up calendar
            let store = EKEventStore()
            
            //request permission to use calendar
            switch EKEventStore.authorizationStatus(for: .event) {
            case .authorized: break
            //access
            case .denied:
                let alert=UIAlertController(title: "Access Denied", message: "If you want to save calendar dates, allow YourClock access in 'privacy settings: calendar'.", preferredStyle: UIAlertControllerStyle.alert);
                //no event handler (just close dialog box)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: nil));
            case .notDetermined:
                store.requestAccess(to: .event, completion:
                    {[weak self] (granted: Bool, error: Error?) -> Void in
                        if granted {
                            //access
                        } else {
                            print("Access denied")
                        }
                })
            default:
                print("Case Default")
            }
            
            //place event essentials inside function
            func createEvent() {
                var calendarLabel: String
                switch self.c % Clocks.caseCount {
                case 1: calendarLabel = self.userClock1.futureCalendarLabel(date: self.userDate, planet: self.planet)
                case 2: calendarLabel = self.userClock2.futureCalendarLabel(date: self.userDate, exoplanet: self.exoplanet)
                case 3: calendarLabel = self.userClock3.futureCalendarLabel(date: self.userDate, galaxy: self.galaxy)
                case 4: calendarLabel = self.userClock4.futureCalendarLabel(date: self.userDate, fun: self.fun)
                case 5: calendarLabel = self.userClock5.futureCalendarLabel(date: self.userDate, sport: self.sport)
                case 6: calendarLabel = self.userClock6.futureCalendarLabel(date: self.userDate, halflife: self.halflife)
                case 7: calendarLabel = self.userClock7.futureCalendarLabel(date: self.userDate, human: self.human)
                case 8: calendarLabel = self.userClock8.futureCalendarLabel(date: self.userDate, lightSpeed: self.lightSpeed)
                case 9: calendarLabel = self.userClock9.futureCalendarLabel(date: self.userDate, classical: self.classical)
                default: calendarLabel = self.userClock.futureCalendarLabel(date: self.userDate, unit: self.unit)
                }
                calendarLabel = user! + calendarLabel
                // create the event object
                let event = EKEvent(eventStore: store)
                event.title = calendarLabel
                event.startDate = futureCalendarDate
                event.endDate = futureCalendarDate
                
                // prompt user to add event (to whatever calendar they want)
                let controller = EKEventEditViewController()
                controller.event = event
                controller.eventStore = store
                controller.editViewDelegate = self
                self.present(controller, animated: true, completion: nil)
            }
            //call function
            createEvent()
        }))
            
            //no event handler (just close dialog box)
            alert.addAction(UIAlertAction(title: "Share", style: UIAlertActionStyle.cancel, handler: {(action:UIAlertAction) in
                self.displayShareSheet(shareContent: randomGreeting() + textLabel + " From YourClock.")
            }))
            
        self.present(alert, animated: true, completion: nil);
        }))
        present(alert, animated: true, completion: nil);
    }
    
    func shareText() {
        let header = "Just Now "
        let myFormatter = DateFormatter()
        myFormatter.dateStyle = .long
        myFormatter.timeStyle = .medium
        let currentDate = myFormatter.string(from: Date())
        let user = secondaryLabel.text
        let main = label.text
        let textUnits = additionalLabel.text
        var text1, text2 : String
        
        switch c % Clocks.caseCount {
        case 0:
            text1 = user! + " turned " + main! + " "
            text2 = textUnits! + " on " + currentDate
            if s == 7 {
                text2 = "on " + currentDate
            }
        case 1: text1 = user! + " turned " + main! + " on "
        text2 = self.userClock1.units(planet: planet).label + " on " + currentDate
        case 2: text1 = user! + " turned " + main! + " on "
        text2 = self.userClock2.units(exoplanet: exoplanet).label + " on " + currentDate
        case 3:
            if galaxy == .neutrinos {
                text1 = main! + " Neutrinos have passed through " + user!
                text2 = " as of " + currentDate
            }
            else if galaxy == .plancktime {
                text1 = user! + " turned " + main! + " "
                text2 = "Planck Lengths on " + currentDate
            }
            else if galaxy == .rpy {
                text1 = user! + " has absorbed " + main!
                text2 = " Milli-sieverts of Radiation as of " + currentDate
            }
            else {
                text1 = user! + " reached " + main! + " "
                text2 = self.userClock3.units(galaxy: galaxy).label + " on " + currentDate
            }
        case 4: text1 = user! + " reached " + main! + " "
        text2 = textUnits! + " on " + currentDate
        
        case 6: text1 = user! + " has reached " + main! + " "
        text2 = self.userClock6.units(halflife: halflife).1 + " as of " + currentDate
        default: text1 = user! + " turned " + main! + " "
        text2 = textUnits! + " on " + currentDate
        }
        let text = text1 + text2 + "."
        
        let alert=UIAlertController(title: header, message: text, preferredStyle: UIAlertControllerStyle.alert);
        
        //no event handler (just close dialog box)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: nil));
        
        alert.addAction(UIAlertAction(title: "Share", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
            self.displayShareSheet(shareContent: randomGreeting() + text + " From YourClock.")
        }))
        
        present(alert, animated: true, completion: nil);
    }
    
    func presentPhoto(){
        
        //Create the UIImage
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        view.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
        let shareText = "From YourClock"
        let header = "Photo Booth"
        let alert=UIAlertController(title: header, message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        //calls function from extensions that place image in alert
        alert.addImage(image: image)
        
        //no event handler (just close dialog box)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: nil));
        
        //event handler with closure
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
            
            //Save it to the camera roll
            //                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            let vc = UIActivityViewController(activityItems: [shareText, image], applicationActivities: [])
            self.present(vc, animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func funFactAlert() {
        var info : String
        var text : String
        let header = "Fun Fact"
        switch c % Clocks.caseCount {
        case 0:
            if s == 7 {
                info = "Age Clock displays the combined years/days/months and hours/minutes/seconds since the provided date."
            }
            else {
            info = userClock.additionalLabel(unit: unit)
            }
        case 1: info = userClock1.additionalLabel(planet: planet)
        case 2: info = userClock2.additionalLabel(exoplanet: exoplanet)
        case 3: info = userClock3.additionalLabel(galaxy: galaxy)
        case 4: info = userClock4.additionalLabel(fun: fun)
        case 5: info = userClock5.additionalLabel(sport: sport)
        case 6: info = userClock6.additionalLabel(halflife: halflife)
        case 7: info = userClock7.additionalLabel(human: human)
        case 8: info = userClock8.additionalLabel1(lightSpeed: lightSpeed)
        case 9: info = userClock9.additionalLabel2(classical: classical)
        default: info = "Time is relative."
        }
        text = info
        let alert=UIAlertController(title: header, message: text, preferredStyle: UIAlertControllerStyle.alert);
        
        //no event handler (just close dialog box)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: nil))
        
        present(alert, animated: true, completion: nil);
    }
    
    func random() {
        c = Int(arc4random_uniform(UInt32(Clocks.caseCount)))
        switch c {
        case 1: p = Int(arc4random_uniform(UInt32(Planet.caseCount)))
        planet = Planet(rawValue: p)!
        case 2: e = Int(arc4random_uniform(UInt32(Exoplanet.caseCount)))
        exoplanet = Exoplanet(rawValue: e)!
        case 3: g = Int(arc4random_uniform(UInt32(Galaxy.caseCount)))
        galaxy = Galaxy(rawValue: g)!
        case 4: f = Int(arc4random_uniform(UInt32(Fun.caseCount)))
        fun = Fun(rawValue: f)!
        case 5: x = Int(arc4random_uniform(UInt32(Sport.caseCount)))
        sport = Sport(rawValue: x)!
        case 6: z = Int(arc4random_uniform(UInt32(Halflife.caseCount)))
        halflife =  Halflife(rawValue: z)!
        case 7: h = Int(arc4random_uniform(UInt32(Human.caseCount)))
        human =  Human(rawValue: h)!
        case 8: l = Int(arc4random_uniform(UInt32(LightSpeed.caseCount)))
        lightSpeed =  LightSpeed(rawValue: l)!
        case 9: a = Int(arc4random_uniform(UInt32(Classical.caseCount)))
        classical =  Classical(rawValue: a)!
        default : s = Int(arc4random_uniform(UInt32(Clocks.caseCount)))
        unit = calendarCall(s: s)
        }
    }
    
    func backSwipe() {
        c-=1
        if c < 0 {
            c = Clocks.caseCount-1
        }
    }
    
    func forwardTap() {
        if c % Clocks.caseCount == 0 {
            s += 1
            if s % 8 != 7 {
                unit = calendarCall(s: s)
            }
        }
        if c % Clocks.caseCount == 1 {
            p += 1
            planet = Planet(rawValue: p % Planet.caseCount)!
        }
        if c % Clocks.caseCount == 2 {
            e += 1
            exoplanet = Exoplanet(rawValue: e % Exoplanet.caseCount)!
        }
        if c % Clocks.caseCount == 3 {
            g += 1
            galaxy = Galaxy(rawValue : g % Galaxy.caseCount)!
        }
        if c % Clocks.caseCount == 4 {
            f += 1
            fun = Fun(rawValue : f % Fun.caseCount)!
        }
        if c % Clocks.caseCount == 5 {
            x += 1
            sport = Sport(rawValue : x % Sport.caseCount)!
        }
        if c % Clocks.caseCount == 6 {
            z += 1
            halflife = Halflife(rawValue : z % Halflife.caseCount)!
        }
        if c % Clocks.caseCount == 7 {
            h += 1
            human = Human(rawValue : h % Human.caseCount)!
        }
        if c % Clocks.caseCount == 8 {
            l += 1
            lightSpeed = LightSpeed(rawValue : l % LightSpeed.caseCount)!
        }
        if c % Clocks.caseCount == 9 {
            a += 1
            classical = Classical(rawValue : a % Classical.caseCount)!
        }
    }
}

extension UIView {
    
    func leftToRightAnimation(duration: TimeInterval = 0.65, completionDelegate: AnyObject? = nil) {
        // Create a CATransition object
        let leftToRightTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided
        if let delegate: AnyObject = completionDelegate {
            leftToRightTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        leftToRightTransition.type = kCATransitionPush
        leftToRightTransition.subtype = kCATransitionFromRight
        leftToRightTransition.duration = duration
        leftToRightTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        leftToRightTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.add(leftToRightTransition, forKey: "leftToRightTransition")
    }
    
    func rightToLeftAnimation(duration: TimeInterval = 0.65, completionDelegate: AnyObject? = nil) {
        // Create a CATransition object
        let rightToLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided
        if let delegate: AnyObject = completionDelegate {
            rightToLeftTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        rightToLeftTransition.type = kCATransitionPush
        rightToLeftTransition.subtype = kCATransitionFromLeft
        rightToLeftTransition.duration = duration
        rightToLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        rightToLeftTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.add(rightToLeftTransition, forKey: "rightToLeftTransition")
    }
}

extension UIAlertController {
    func addImage(image: UIImage) {
        
        let maxSize = CGSize(width: 245, height: 300)
        let imgSize = image.size
        
        var ratio : CGFloat!
        //        if imgSize.width > imgSize.height {
        //            ratio = maxSize.width / imgSize.width
        //        }
        //        else {
        //            ratio = maxSize.height / imgSize.height
        //        }
        
        ratio = maxSize.width / imgSize.width
        
        let scaledSize = CGSize(width: imgSize.width * ratio, height: imgSize.height * ratio)
        let resizedImage = image.imageWithSize(scaledSize)
        
        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        imgAction.isEnabled = false
        imgAction.setValue(resizedImage.withRenderingMode(.alwaysOriginal), forKey: "image")
        self.addAction(imgAction)
    }
}

extension UIImage {
    func imageWithSize(_ size:CGSize) -> UIImage {
        var scaledImageRect = CGRect.zero
        
        let aspectWidth:CGFloat = size.width / self.size.width
        let aspectHeight:CGFloat = size.height / self.size.height
        let aspectRatio:CGFloat = min(aspectWidth, aspectHeight)
        
        scaledImageRect.size.width = self.size.width * aspectRatio
        scaledImageRect.size.height = self.size.height * aspectRatio
        scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0
        scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        self.draw(in: scaledImageRect)
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
}

extension MasterViewController: EKEventEditViewDelegate {
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}

