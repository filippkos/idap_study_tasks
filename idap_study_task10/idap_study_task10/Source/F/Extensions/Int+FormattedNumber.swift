//
//  Int+FormattedNumber.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 11.05.2023.
//

import Foundation

extension Int {
    
    static func intToFormattedIdString(number: Int) -> String {
        return "#\(String(format: "%03d", number))"
    }
}

