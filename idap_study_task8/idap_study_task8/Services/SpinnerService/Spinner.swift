//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

public protocol Spinner: AnyObject {

    associatedtype SpinnerView: UIView

    static func preparedSpinner() -> SpinnerView
}

class SpinnerService {

    private static var spinners = [UIView : WeakBox<UIView>]()
    private static var backgroundsView = [UIView : WeakBox<UIView>]()

    static func show<ProviderType: Spinner, Type>(
        on view: UIView,
        provider: ProviderType.Type,
        configure: F.VoidFunc<Type>?
    )
        where ProviderType.SpinnerView == Type
    {
        let spinner = provider.preparedSpinner()
        let backgroundView = UIView(frame: view.frame)

        WeakBox(view).wrapped.map {
            self.spinners[$0] = WeakBox(spinner)
            self.backgroundsView[$0] = WeakBox(backgroundView)
        }

        backgroundView.backgroundColor = .clear
        view.addSubview(backgroundView)

        spinner.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        spinner.alpha = 0

        configure?(spinner)
        view.addSubview(spinner)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = spinner.widthAnchor.constraint(equalTo: view.widthAnchor)
        let heightConstraint = spinner.heightAnchor.constraint(equalTo: view.heightAnchor)

        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

        UIView.animate(
            withDuration: 0,
            delay: 0.1,
            options: .curveLinear,
            animations: {
                spinner.alpha = 1
            },
            completion: { _ in }
        )
    }
    static func hide<ProviderType: Spinner, Type>(
            from view: UIView,
            provider: ProviderType.Type,
            configure: F.VoidFunc<Type>?
    ) {
        let spinner = self.spinners.removeValue(forKey: view)
        let backgroundView = self.backgroundsView.removeValue(forKey: view)

        DispatchQueue.main.async {
            spinner?.wrapped?.removeFromSuperview()
            backgroundView?.wrapped?.removeFromSuperview()
        }
    }
}
