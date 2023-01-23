//Created for idap_study_task8 in 2023
// Using Swift 5.0

import UIKit

final class ImageService {
    
    // MARK: -
    // MARK: Variables
    
    let networkManager = NetworkManager()
    let storageService = StorageService()
    
    // MARK: -
    // MARK: internal
    
    func image(
        for model: Pokemon,
        completion: @escaping F.VoidFunc<UIImage?>,
        alertHandler: @escaping F.VoidFunc<Error>
    ) {
        self.storageService.checkDirectory(name: model.name, completion: { image in
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
    
    private func getImage(
        model: Pokemon,
        completion: @escaping F.VoidFunc<UIImage?>,
        alertHandler: @escaping F.VoidFunc<Error>)
    {
        self.networkManager.getImage(from: model.sprites?.frontDefault ?? "") { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(image):
                    print("<#> Image \(model.name) is loaded from network.")
                    self?.storageService.createImage(image: image, name: model.name)
                    completion(image)
                case let .failure(error):
                    alertHandler(error)
                }
            }
        }
    }
}
