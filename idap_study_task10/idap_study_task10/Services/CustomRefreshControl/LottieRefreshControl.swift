//
//  LottieRefreshControl.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 17.07.2023.
//

import UIKit
import Lottie

class LottieRefreshControl: UIRefreshControl {
    
    private var animationView = LottieAnimationView(name: "")
    
    override init() {
        super.init(frame: .zero)
        
        self.tintColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func beginRefreshing() {
        super.beginRefreshing()
        
        self.animationView.currentProgress = 0
        DispatchQueue.main.async {
            self.animationView.play()
        }
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        
        self.animationView.stop()
    }
    
    func setLottieAnimation(name: String) {
        self.tintColor = .clear
        self.animationView = LottieAnimationView(name: name)
        self.animationView.loopMode = .loop
        self.addSubview(self.animationView)
    }
    
    func setupLayout() {
        self.animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            self.animationView.widthAnchor.constraint(equalToConstant: 50),
            self.animationView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
