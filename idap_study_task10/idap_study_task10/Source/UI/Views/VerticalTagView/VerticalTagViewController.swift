//
//  VerticalTagView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 03.05.2023.
//

import UIKit

struct VerticalTagItem {
    
    let leftImage: UIImage?
    let title: String
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
    
    func getImage(typeName: String) -> UIImage {
        switch typeName {
        case "fighting":
            return Images.PokemonTypeIcons.fighting.image
        case "psychic":
            return Images.PokemonTypeIcons.psychic.image
        case "poison":
            return Images.PokemonTypeIcons.poison.image
        case "dragon":
            return Images.PokemonTypeIcons.dragon.image
        case "ghost":
            return Images.PokemonTypeIcons.ghost.image
        case "dark":
            return Images.PokemonTypeIcons.dark.image
        case "ground":
            return Images.PokemonTypeIcons.ground.image
        case "fire":
            return Images.PokemonTypeIcons.fire.image
        case "fairy":
            return Images.PokemonTypeIcons.fairy.image
        case "water":
            return Images.PokemonTypeIcons.water.image
        case "flying":
            return Images.PokemonTypeIcons.flying.image
        case "normal":
            return Images.PokemonTypeIcons.normal.image
        case "rock":
            return Images.PokemonTypeIcons.rock.image
        case "electric":
            return Images.PokemonTypeIcons.electric.image
        case "bug":
            return Images.PokemonTypeIcons.bug.image
        case "grass":
            return Images.PokemonTypeIcons.grass.image
        case "ice":
            return Images.PokemonTypeIcons.icy.image
        case "steel":
            return Images.PokemonTypeIcons.steel.image
        default:
            return UIImage()
        }
    }

    // MARK: -
    // MARK: Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: ChipCollectionViewCell.self, indexPath: indexPath)
        cell.text?.text = self.items[indexPath.row].title
        if self.isImagesEnabled {
            cell.image.image = getImage(typeName: self.items[indexPath.row].title)
            
        }
        cell.backgroundColor = Colors.Colors.wildSand.color
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

