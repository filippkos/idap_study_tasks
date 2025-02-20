//
//  SpinnerService.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit
import Lottie

public class SpinnerView: Spinner {

    public static func preparedSpinner() -> UIView {
        let bg = UIView(frame: .init(x: 0, y: 0, width: 60, height: 60))
        bg.backgroundColor = .clear
        let plate = UIView(frame: .init(x: 0, y: 0, width: 60, height: 60))
        plate.backgroundColor = .clear
        plate.layer.cornerRadius = 10
        
        let indicator = LottieAnimationView(name: "pokeball")

        bg.addSubview(plate)
        plate.addSubview(indicator)

        self.addCenteredConstraint(view: plate, superview: bg, heightOffset: -40)
        self.addCenteredConstraint(view: indicator, superview: plate)

        indicator.play()

        return bg
    }

    private static func addCenteredConstraint(
        view: UIView,
        superview: UIView,
        heightOffset: CGFloat = 0
    ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = view.centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        let verticalConstraint = view.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: heightOffset)
        let widthConstraint = view.widthAnchor.constraint(equalToConstant: 60)
        let heightConstraint = view.heightAnchor.constraint(equalToConstant: 60)

        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}
