//
//  DashboardContentModel.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 07.03.2023.
//

import UIKit

enum DashboardContentModel: CaseIterable {
    
    case first
    case second
    case third
    
    private typealias Loc = L10n.Dashboard
    
    var isVisible: Bool {
        self == .third
    }
    
    var title: String {
        switch self {
        case .first:
            return Loc.First.title
        case .second:
            return Loc.Second.title
        case .third:
            return Loc.Third.title
        }
    }
    
    var description: String {
        switch self {
        case .first:
            return Loc.First.description
        case .second:
            return Loc.Second.description
        case .third:
            return Loc.Third.description
        }
    }
    
    var image: UIImage {
        switch self {
        case .first:
            return Images.pokemon.image
        case .second:
            return Images.purplePokemon.image
        case .third:
            return Images.allPokemons.image
        }
    }
}
