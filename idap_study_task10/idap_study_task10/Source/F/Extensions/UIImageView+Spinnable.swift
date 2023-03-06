//
//  UIImageView+ Spinnable.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

extension UIImageView: Spinnable {

    // MARK: -
    // MARK: Typealiases
    
    public typealias SpinnerType = SpinnerView
    
    // MARK: -
    // MARK: Variables
    
    public var isLoaded: Bool {
        get {
            false
        }
        set {
            false
        }
    }
}
