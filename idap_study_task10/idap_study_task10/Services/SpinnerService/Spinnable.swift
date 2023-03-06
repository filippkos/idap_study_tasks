//
//  Spinnable.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

public protocol Spinnable: AnyObject {

    associatedtype SpinnerType: Spinner

    /// Do not set properly, just get
    var isLoaded: Bool { get set }

    func showSpinner()
    func showSpinner(on view: UIView?, configure: F.VoidFunc<SpinnerType.SpinnerView>?)

    func hideSpinner()
    func hideSpinner(on view: UIView?, configure: F.VoidFunc<SpinnerType.SpinnerView>?)
}

extension Spinnable where Self: UIView {

    public func showSpinner() {
        self.showSpinner(configure: nil)
    }

    public func hideSpinner() {
        self.hideSpinner(configure: nil)
    }

    public func showSpinner(on view: UIView? = nil, configure: F.VoidFunc<SpinnerType.SpinnerView>?) {
        self.isLoaded = true
        SpinnerService.show(on: view ?? self, provider: SpinnerType.self, configure: configure)
    }

    public func hideSpinner(on view: UIView? = nil, configure: F.VoidFunc<SpinnerType.SpinnerView>?) {
        self.isLoaded = false
        SpinnerService.hide(from: view ?? self, provider: SpinnerType.self, configure: configure)
    }
}

extension Spinnable where Self: UIViewController {

    public func showSpinner() {
        self.showSpinner(configure: nil)
    }

    public func hideSpinner() {
        self.hideSpinner(configure: nil)
    }

    public func showSpinner(on view: UIView? = nil, configure: F.VoidFunc<SpinnerType.SpinnerView>?) {
        self.isLoaded = true
        self.hideSpinner()
        SpinnerService.show(on: view ?? self.view, provider: SpinnerType.self, configure: configure)
    }

    public func hideSpinner(on view: UIView? = nil, configure: F.VoidFunc<SpinnerType.SpinnerView>?) {
        self.isLoaded = false
        SpinnerService.hide(from: view ?? self.view, provider: SpinnerType.self, configure: configure)
    }
}
