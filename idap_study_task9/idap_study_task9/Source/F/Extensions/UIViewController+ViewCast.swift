//
//  UIViewController+ViewCast.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 30.01.2023.
//

import UIKit

protocol RootViewGettable: UIViewController {
    
    associatedtype RootView: UIView
    var rootView: RootView? { get }
}

extension RootViewGettable {
    var rootView: RootView? {
        self.view as? RootView
    }
}
