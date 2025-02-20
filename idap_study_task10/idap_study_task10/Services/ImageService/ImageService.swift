//
//  ImageService.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

protocol ImageServiceType {
    
    var networkManager: NetworkManagerType { get }
    var storageService: StorageServiceType { get }
    
    func image(
        for model: Pokemon,
        completion: @escaping F.VoidFunc<UIImage?>,
        alertHandler: @escaping F.VoidFunc<Error>
    )
    func getImage(
        model: Pokemon,
        completion: @escaping F.VoidFunc<UIImage?>,
        alertHandler: @escaping F.VoidFunc<Error>
    )
}

final class ImageService: ImageServiceType {
    
    // MARK: -
    // MARK: Variables
    
    let networkManager: NetworkManagerType
    let storageService: StorageServiceType
    
    // MARK: -
    // MARK: Init
    
    init(networkManager: NetworkManagerType, storageService: StorageServiceType) {
        self.networkManager = networkManager
        self.storageService = storageService
    }
    
    // MARK: -
    // MARK: internal
    
    func image(
        for model: Pokemon,
        completion: @escaping F.VoidFunc<UIImage?>,
        alertHandler: @escaping F.VoidFunc<Error>
    ) {
        let name = model.sprites?.frontDefaultEncoded ?? ""
        self.storageService.checkDirectory(name: name, completion: { image in
            switch image {
            case let .success(image):
                if image != nil {
                    completion(image)
                } else {
                    self.getImage(model: model) { image in
                        completion(image)
                    } alertHandler: { error in
                        alertHandler(error)
                    }
                }
            case let .failure(error):
                alertHandler(error)
            }
        }
        )
   }
    
    // MARK: -
    // MARK: Private
    
    internal func getImage(
        model: Pokemon,
        completion: @escaping F.VoidFunc<UIImage?>,
        alertHandler: @escaping F.VoidFunc<Error>)
    {
        let name = model.sprites?.frontDefaultEncoded ?? ""
        self.networkManager.getImage(from: model.sprites?.frontDefault ?? "") { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(image):
                    print("<#> Image \(model.name) is loaded from network.")
                    self?.storageService.createImage(image: image, name: name)
                    completion(image)
                case let .failure(error):
                    alertHandler(error)
                }
            }
        }
    }
}
