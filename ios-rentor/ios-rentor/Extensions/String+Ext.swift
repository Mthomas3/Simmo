//
//  String+Ext.swift
//  ios-rentor
//
//  Created by Thomas on 11/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

extension String {
    
    func concat(string: String) -> String{
        return "\(self)\(string)"
    }
    
    func currencyFormatting(formatterDigit: Int) -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = formatterDigit
            formatter.minimumFractionDigits = formatterDigit
            formatter.numberStyle = .decimal
            if let str = formatter.string(for: value) {
                return str.concat(string: " $")
            }
        }
        return ""
    }
    
    func numberFormatting(formatterDigit: Int, isDecimal: Bool) -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = formatterDigit
            formatter.minimumFractionDigits = formatterDigit
            if isDecimal { formatter.numberStyle = .decimal }
            if let str = formatter.string(for: value) {
                return "\(str)"
            }
        }
        return ""
    }
}
