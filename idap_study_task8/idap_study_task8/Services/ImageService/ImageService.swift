//Created for idap_study_task8 in 2023
// Using Swift 5.0

import UIKit

final class ImageService {
    
    let networkManager = NetworkManager()
    let storageService = StorageService()
    
    func image(
        for model: Pokemon,
        completion: @escaping (UIImage?) -> Void,
        taskHandler: @escaping (URLSessionDataTask?) -> (),
        alertHandler: @escaping (Error?) -> ()
    ) {
        
        var image: UIImage?
        
        self.storageService.checkDirectory(name: model.name, completion: { image in
            switch image {
            case let .success(image):
                if image != nil {
                    completion(image)
                } else {
                    let task = self.getImage(model: model) { image in
                        completion(image)
                    } alertHandler: { error in
                        alertHandler(error)
                    } as! URLSessionDataTask
                    taskHandler(task)
                }
            case let .failure(error):
                alertHandler(error)
            }
        }
        )
   }
    
  private func getImage(model: Pokemon, completion: @escaping (UIImage?) -> Void, alertHandler: @escaping (Error?) -> ()) -> Cancellable {
        let task = self.networkManager.getImage(from: model.sprites?.frontDefault ?? "") { result in
            defer {
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case let .success(image):
                        
                            self?.storageService.createImage(image: image, name: model.name)
                            completion(image)
                
                    case let .failure(error):
                        alertHandler(error)
                    }
                }
            }
        }
      task.resume()
    
      return task
    }
}
