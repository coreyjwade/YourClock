//
//  MathFunctions.swift
//  TimeVention2PW
//
//  Created by Corey Wade on 1/7/18.
//  Copyright © 2018 Corey Wade. All rights reserved.
//

import Foundation


//needed to return integer exponent
func tenToThe(_ power: Int) -> Int {
    var result = 1
    for _ in 1...power {
        result *= 10
    }
    return result
}

//Rounds Int up to desired number of zeroes
func zeroConverter(Nonzeroes : Int , numberToConvert : Int) -> Int? {
    let str = String(numberToConvert)
    let index = str.index(str.startIndex, offsetBy: Nonzeroes)
    let mySubstring = str[..<index]
    
    if let x = Int(mySubstring) {
        var newString = String(x + 1)
        for _ in 1..<str.count - Nonzeroes - 1 {
            newString.append("0")
        }
        return Int(newString)!
    }
    else {
        return nil
    }
}

func nextNumZeroes1 (x: Int) -> Int {
    var i = 1
    while x/i > 10 {
        i = i * 10
    }
    return (x/i + 1) * i
}

func nextNumZeroes2 (x: Int) -> (Int, Int) {
    var i = 1
    while x/i > 10 {
        i = i * 10
    }
    let big = (x/i + 1) * i
    i = 1
    while x/i > 100 {
        i = i * 10
    }
    let small = (x/i + 1) * i
    return (big, small)
}


//for 54321 would return 60000, 55000, 54400
func futureZeroes(units: Int) -> [Int] {
    var result = [Int]()
    for i in 1...3 {
        let x = zeroConverter(Nonzeroes: i, numberToConvert: units)
        if let y = x {
            result.append(y)
        }
    }
    return result
}

func nextNumber(units: Int) -> Int {
    return units + 1
}


//finds next number that repeats all digits
func futureRepeat(units: Int) -> Int {
    let currentString = String(units)
    let oneString = String(currentString[currentString.startIndex])
    var newString = oneString
    for _ in 1..<currentString.count {
        newString.append(oneString)
    }
    return Int(newString)!
}


//finds next number that displays decimal representation of pi
func futurePi(num: Int) -> Int {
    let currentString = String(num)
    var length = currentString.count
    if length < 3 {
        return 314
    }
    let pi = "314159265358979323846264338327950288419716939937510582097494459230781640628620899862803482534211706798214808651328230664709384460955058223172535940812848111745028410270193852110555964462294895493038196442881097566593344612847564823378678316527120190914564856692346034861045432664821339360726024914127372458700660631558817488152092096282925409171536436789259036001133053054882046652138414695194151160943305727036575959195309218611738193261179310511854807446237996274956735188575272489122793818301194912983367336244065664308602139494639522473719070217986094370277053921717629317675238467481846766940513200056812714526356082778577134275778960917363717872146844090122495343014654958537105079227968925892354201995611212902196086403441815981362977477130996051870721134999999837297804995105973173281609631859502445945534690830264252230825334468503526193118817101000313783875288658753320838142061717766914730359825349042875546873115956286388235378759375195778185778053217122680661300192787661119590921642019893809525720106548586"
    var newString = "3"
    let piComparison = Int(Double.pi * Double(tenToThe(length)/10))
    if num > piComparison {
        length += 1
    }
    for i in 1 ..< length {
        newString.append(String(pi[pi.index(pi.startIndex, offsetBy: i )]))
    }
    return Int(newString)!
}

//Must be reworked for digits exceeding 9
func futureCountDown(units: Int) -> Int {
    let currentString = String(units)
    var length = currentString.count
    if length < 3 {
        return 321
    }
    func countDown(length: Int) -> Int {
        var newString = String(length)
        for i in 1 ..< length {
            newString.append(String(length - i))
        }
        return Int(newString)!
    }
    let count = countDown(length: length)
    if count > units {
        return count
    }
    else {
        return countDown(length: length+1)
    }
}

//Must be reworked for digits exceeding 9
func futureCountUp(units: Int) -> Int {
    let currentString = String(units)
    var length = currentString.count
    if length < 3 {
        return 123
    }
    func countUp(length: Int) -> Int {
        var newString = ""
        for i in 1 ... length {
            newString.append(String(i))
        }
        return Int(newString)!
    }
    let count = countUp(length: length)
    if count > units {
        return count
    }
    else {
        return countUp(length: length+1)
    }
    
}
