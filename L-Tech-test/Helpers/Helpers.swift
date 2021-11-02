//
//  Helper.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 21.10.2021.
//

import Foundation


public func format(phonenumber: String, maskNumber: MaskNumberModel?, shouldRemoveLastDigit: Bool = false, range: NSRange = NSRange()) -> (String) {
//    public func format(phonenumber: String, maskNumber: MaskNumberModel?, shouldRemoveLastDigit: Bool, shouldRemoveDigits: Bool, range: NSRange) -> (String) {
    guard let maskNumber = maskNumber else {return ("")}
    var phoneMaskSeparated = maskNumber.phoneMask.split(separator: " ")
    let startDigits = String(phoneMaskSeparated.removeFirst())
    let mask = phoneMaskSeparated.joined(separator: " ")
    print(mask)
    var countDigitsInMask = 0
    for ch in mask {
        if ch == "Х" {
            countDigitsInMask += 1
        }
    }
    let clearPhoneNumber = phonenumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    var number = ""
    if clearPhoneNumber.count == 0 || clearPhoneNumber.isEmpty {
        number = ""
    } else if clearPhoneNumber.count == 1 {
        number = String(clearPhoneNumber.last!)
    } else {
        let iindex = startDigits.index(before: startDigits.endIndex)
        number = String(clearPhoneNumber[iindex..<clearPhoneNumber.endIndex])
    }
    guard !(shouldRemoveLastDigit && number.count <= 1) else {return (startDigits)}
    print(number)
    if number.count > countDigitsInMask {
        let maxIndex = number.index(number.startIndex, offsetBy: countDigitsInMask)
        number = String(number[number.startIndex..<maxIndex])
    }
    if shouldRemoveLastDigit {
        let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
        number = String(number[number.startIndex..<maxIndex])
    }
//    if shouldRemoveDigits {
//       print(range)
//        let maxIndex = number.index(number.startIndex, offsetBy: number.count - range.length)
//        number = String(number[number.startIndex..<maxIndex])
//    }
    var sample = ""
    var index = number.startIndex
    
    for ch in mask {
        if index == number.endIndex {
            break
        }
        if ch == "Х" {
            sample.append(number[index])
            index = number.index(after: index)
            
        } else {
            sample.append(ch)
        }
    }
    print(number)
    return (startDigits + " " + sample)
}



public func getDateFromString(inputDate: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let date = dateFormatter.date(from: inputDate)
    return date
}



public func getStringFromDate(inputDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let stringDate = dateFormatter.string(from: inputDate)
    return stringDate
}
