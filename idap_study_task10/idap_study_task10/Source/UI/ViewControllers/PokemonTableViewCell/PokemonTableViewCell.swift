//
//  PokemonTableViewCell.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    // MARK: -
    // MARK: Outlets
    
    @IBOutlet internal var parameterLabel: UILabel?
    
    // MARK: -
    // MARK: Variables
    
    private(set) var id = UUID()
    
    // MARK: -
    // MARK: Public
    
    public func fill(text: String) {
        self.parameterLabel?.text = text
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.id = UUID()
    }
}
