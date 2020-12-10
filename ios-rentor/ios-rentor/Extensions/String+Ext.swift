//
//  String+Ext.swift
//  ios-rentor
//
//  Created by Thomas on 11/09/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import Foundation

extension String {
    
    private func getLocaleCurrency() -> String { Locale.current.currencySymbol ?? "€" }
    
    func concat(string: String) -> String { "\(self)\(string)" }
    
    func currencyFormatting() -> String { self.concat(string: " ").concat(string: self.getLocaleCurrency()) }
    
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
