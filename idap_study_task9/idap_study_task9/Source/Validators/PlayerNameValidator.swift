//
//  PlayerNameValidator.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 26.02.2023.
//

import Foundation

public final class PlayerNameValidator {
    
    public static let minLength = 1
    
    public static func isValid(_ name: String) -> Bool {
        let result = name.trimmingCharacters(in: .whitespaces)
        return result.count >= Self.minLength
    }
    
    public static func isEqual(_ firstName: String, _ secondName: String) -> Bool {
        return firstName == secondName
    }
}
