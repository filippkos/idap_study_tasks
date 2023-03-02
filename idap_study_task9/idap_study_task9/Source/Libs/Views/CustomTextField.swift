//
//  CustomTextField.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 17.02.2023.
//

import UIKit
import SnapKit

@IBDesignable
final class CustomTextField: UIControl, UITextFieldDelegate {
    
    // MARK: -
    // MARK: Variables
    
    let field = UITextField()
    let titleLabel = UILabel()
    let errorLabel = UILabel()
    private let stackView = UIStackView()
    private let fieldContainer = UIView()

    // MARK: -
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setup()
    }
    
    
    private func setup() {
        self.addSubview(stackView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.field)
        self.stackView.addArrangedSubview(self.errorLabel)
        self.prepareStackView()
        self.prepareErrorLabel()
        self.prepareTextField()
        self.prepareTitle()
    }
    
    private func prepareStackView() {
        self.stackView.axis = .vertical
        self.stackView.spacing = 2
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.prepareStackViewConstraints()
    }
    
    private func prepareTitle() {
        self.titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        self.titleLabel.backgroundColor = .clear
    }
    
    private func prepareTextField() {
        self.field.backgroundColor = .lightGray
        self.field.borderStyle = .roundedRect
    }
    
    private func prepareErrorLabel() {
        self.errorLabel.textColor = .systemRed
    }
    
    private func prepareStackViewConstraints() {
        self.stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(24)
        }
    }
}
