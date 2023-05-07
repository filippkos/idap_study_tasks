//
//  VerticalTagView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 03.05.2023.
//

import UIKit

struct VerticalTagItem {
    
    let leftImage: UIImage?
    let backgroundColor: UIColor?
    let textColor: UIColor?
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
    
    func fillItem(item: VerticalTagItem) -> VerticalTagItem {
        switch item.title {
        case "fighting":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.fighting.image,
                backgroundColor: Colors.PokemonTypesBgColors.fighting.color,
                textColor: Colors.PokemonTypesMainColors.fighting.color,
                title: item.title
            )
        case "psychic":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.psychic.image,
                backgroundColor: Colors.PokemonTypesBgColors.psychic.color,
                textColor: Colors.PokemonTypesMainColors.psychic.color,
                title: item.title
            )
        case "poison":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.poison.image,
                backgroundColor: Colors.PokemonTypesBgColors.poison.color,
                textColor: Colors.PokemonTypesMainColors.poison.color,
                title: item.title
            )
        case "dragon":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.dragon.image,
                backgroundColor: Colors.PokemonTypesBgColors.dragon.color,
                textColor: Colors.PokemonTypesMainColors.dragon.color,
                title: item.title
            )
        case "ghost":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.ghost.image,
                backgroundColor: Colors.PokemonTypesBgColors.ghost.color,
                textColor: Colors.PokemonTypesMainColors.ghost.color,
                title: item.title
            )
        case "dark":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.dark.image,
                backgroundColor: Colors.PokemonTypesBgColors.dark.color,
                textColor: Colors.PokemonTypesMainColors.dark.color,
                title: item.title
            )
        case "ground":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.ground.image,
                backgroundColor: Colors.PokemonTypesBgColors.ground.color,
                textColor: Colors.PokemonTypesMainColors.ground.color,
                title: item.title
            )
        case "fire":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.fire.image,
                backgroundColor: Colors.PokemonTypesBgColors.fire.color,
                textColor: Colors.PokemonTypesMainColors.fire.color,
                title: item.title
            )
        case "fairy":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.fairy.image,
                backgroundColor: Colors.PokemonTypesBgColors.fairy.color,
                textColor: Colors.PokemonTypesMainColors.fairy.color,
                title: item.title
            )
        case "water":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.water.image,
                backgroundColor: Colors.PokemonTypesBgColors.water.color,
                textColor: Colors.PokemonTypesMainColors.water.color,
                title: item.title
            )
        case "flying":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.flying.image,
                backgroundColor: Colors.PokemonTypesBgColors.flying.color,
                textColor: Colors.PokemonTypesMainColors.flying.color,
                title: item.title
            )
        case "normal":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.normal.image,
                backgroundColor: Colors.PokemonTypesBgColors.normal.color,
                textColor: Colors.PokemonTypesMainColors.normal.color,
                title: item.title
            )
        case "rock":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.rock.image,
                backgroundColor: Colors.PokemonTypesBgColors.rock.color,
                textColor: Colors.PokemonTypesMainColors.rock.color,
                title: item.title
            )
        case "electric":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.electric.image,
                backgroundColor: Colors.PokemonTypesBgColors.electric.color,
                textColor: Colors.PokemonTypesMainColors.electric.color,
                title: item.title
            )
        case "bug":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.bug.image,
                backgroundColor: Colors.PokemonTypesBgColors.bug.color,
                textColor: Colors.PokemonTypesMainColors.bug.color,
                title: item.title
            )
        case "grass":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.grass.image,
                backgroundColor: Colors.PokemonTypesBgColors.grass.color,
                textColor: Colors.PokemonTypesMainColors.grass.color,
                title: item.title
            )
        case "ice":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.icy.image,
                backgroundColor: Colors.PokemonTypesBgColors.icy.color,
                textColor: Colors.PokemonTypesMainColors.icy.color,
                title: item.title
            )
        case "steel":
            return VerticalTagItem(
                leftImage: Images.PokemonTypeIcons.steel.image,
                backgroundColor: Colors.PokemonTypesBgColors.steel.color,
                textColor: Colors.PokemonTypesMainColors.steel.color,
                title: item.title
            )
        default:
            return VerticalTagItem(
                leftImage: nil,
                backgroundColor: nil,
                textColor: nil,
                title: item.title
            )
        }
    }
    
    

    // MARK: -
    // MARK: Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: ChipCollectionViewCell.self, indexPath: indexPath)
        let item = fillItem(item: self.items[indexPath.row])
        cell.text?.text = self.items[indexPath.row].title
        
        if self.isImagesEnabled {
            cell.image.image = item.leftImage
            cell.text.textColor = item.textColor
            cell.stackView.backgroundColor = item.backgroundColor
        }
        cell.backgroundColor = Colors.Colors.wildSand.color
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

