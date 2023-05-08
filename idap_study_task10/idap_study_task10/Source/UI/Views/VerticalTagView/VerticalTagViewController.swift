//
//  VerticalTagView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 03.05.2023.
//

import UIKit

enum PokemonType: String, Codable {
    
    case fighting
    case psychic
    case poison
    case dragon
    case ghost
    case dark
    case ground
    case fire
    case fairy
    case water
    case flying
    case normal
    case rock
    case electric
    case bug
    case grass
    case icy
    case steel
    
    var image: UIImage {
        switch self {
        case .fighting:
            return Images.PokemonTypeIcons.fighting.image
        case .psychic:
            return Images.PokemonTypeIcons.psychic.image
        case .poison:
            return Images.PokemonTypeIcons.poison.image
        case .dragon:
            return Images.PokemonTypeIcons.dragon.image
        case .ghost:
            return Images.PokemonTypeIcons.ghost.image
        case .dark:
            return Images.PokemonTypeIcons.dark.image
        case .ground:
            return Images.PokemonTypeIcons.ground.image
        case .fire:
            return Images.PokemonTypeIcons.fire.image
        case .fairy:
            return Images.PokemonTypeIcons.fairy.image
        case .water:
            return Images.PokemonTypeIcons.water.image
        case .flying:
            return Images.PokemonTypeIcons.flying.image
        case .normal:
            return Images.PokemonTypeIcons.normal.image
        case .rock:
            return Images.PokemonTypeIcons.rock.image
        case .electric:
            return Images.PokemonTypeIcons.electric.image
        case .bug:
            return Images.PokemonTypeIcons.bug.image
        case .grass:
            return Images.PokemonTypeIcons.grass.image
        case .icy:
            return Images.PokemonTypeIcons.icy.image
        case .steel:
            return Images.PokemonTypeIcons.steel.image
        }
    }
    
    var color: UIColor {
        switch self {
        case .fighting:
            return Colors.PokemonTypesBgColors.fighting.color
        case .psychic:
            return Colors.PokemonTypesBgColors.psychic.color
        case .poison:
            return Colors.PokemonTypesBgColors.poison.color
        case .dragon:
            return Colors.PokemonTypesBgColors.dragon.color
        case .ghost:
            return Colors.PokemonTypesBgColors.ghost.color
        case .dark:
            return Colors.PokemonTypesBgColors.dark.color
        case .ground:
            return Colors.PokemonTypesBgColors.ground.color
        case .fire:
            return Colors.PokemonTypesBgColors.fire.color
        case .fairy:
            return Colors.PokemonTypesBgColors.fairy.color
        case .water:
            return Colors.PokemonTypesBgColors.water.color
        case .flying:
            return Colors.PokemonTypesBgColors.flying.color
        case .normal:
            return Colors.PokemonTypesBgColors.normal.color
        case .rock:
            return Colors.PokemonTypesBgColors.rock.color
        case .electric:
            return Colors.PokemonTypesBgColors.electric.color
        case .bug:
            return Colors.PokemonTypesBgColors.bug.color
        case .grass:
            return Colors.PokemonTypesBgColors.grass.color
        case .icy:
            return Colors.PokemonTypesBgColors.icy.color
        case .steel:
            return Colors.PokemonTypesBgColors.steel.color
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .fighting:
            return Colors.PokemonTypesMainColors.fighting.color
        case .psychic:
            return Colors.PokemonTypesMainColors.psychic.color
        case .poison:
            return Colors.PokemonTypesMainColors.poison.color
        case .dragon:
            return Colors.PokemonTypesMainColors.dragon.color
        case .ghost:
            return Colors.PokemonTypesMainColors.ghost.color
        case .dark:
            return Colors.PokemonTypesMainColors.dark.color
        case .ground:
            return Colors.PokemonTypesMainColors.ground.color
        case .fire:
            return Colors.PokemonTypesMainColors.fire.color
        case .fairy:
            return Colors.PokemonTypesMainColors.fairy.color
        case .water:
            return Colors.PokemonTypesMainColors.water.color
        case .flying:
            return Colors.PokemonTypesMainColors.flying.color
        case .normal:
            return Colors.PokemonTypesMainColors.normal.color
        case .rock:
            return Colors.PokemonTypesMainColors.rock.color
        case .electric:
            return Colors.PokemonTypesMainColors.electric.color
        case .bug:
            return Colors.PokemonTypesMainColors.bug.color
        case .grass:
            return Colors.PokemonTypesMainColors.grass.color
        case .icy:
            return Colors.PokemonTypesMainColors.icy.color
        case .steel:
            return Colors.PokemonTypesMainColors.steel.color
        }
    }
}

struct VerticalTagItem {
    
    let leftImage: UIImage?
    let backgroundColor: UIColor?
    let textColor: UIColor?
    let title: String
    
    public init(leftImage: UIImage?, backgroundColor: UIColor?, textColor: UIColor?, title: String) {
        self.leftImage = leftImage
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.title = title
    }
    
    public init(type: PokemonType) {
        self.title = type.rawValue
        self.backgroundColor = type.color
        self.textColor = type.textColor
        self.leftImage = type.image
    }
}

class VerticalTagViewController: NibDesignable, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: -
    // MARK: Outlets

    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: -
    // MARK: Variables

    var items: [VerticalTagItem] = []
    var isImagesEnabled: Bool = false
    
    // MARK: -
    // MARK: Overrided
    
    override func configureView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView?.register(cellClass: ChipCollectionViewCell.self)
        self.collectionView.isScrollEnabled = false
    }

    // MARK: -
    // MARK: Public

    func configure(with models: [VerticalTagItem]) {
        self.items = models
        self.collectionView.reloadData()
    }

    // MARK: -
    // MARK: Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: ChipCollectionViewCell.self, indexPath: indexPath)
        let item = self.fillItem(item: self.items[indexPath.row])
        
        cell.text.text = item.title.capitalizingFirstLetter()
        if self.isImagesEnabled {
            cell.image.image = item.leftImage
            cell.text.textColor = item.textColor
            cell.stackView.backgroundColor = item.backgroundColor
        } else {
            cell.imageContainer.isHidden = true
            cell.stackView.backgroundColor = Colors.Colors.wildSand.color
        }

        return cell
    }
    
    // MARK: -
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

