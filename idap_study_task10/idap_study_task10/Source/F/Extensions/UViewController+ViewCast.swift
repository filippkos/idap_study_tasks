//
//  UViewController+ViewCast.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
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
