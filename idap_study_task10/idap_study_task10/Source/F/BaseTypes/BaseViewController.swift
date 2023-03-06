//
//  BaseViewController.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: -
    // MARK: Variables
    
    private let serviceManager: ServiceManager
    
    // MARK: -
    // MARK: Init
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Deinit
    
    deinit {
        debugPrint("deinit - \(type(of: self))")
    }
}
