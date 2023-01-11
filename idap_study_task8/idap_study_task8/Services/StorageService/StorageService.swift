//Created for idap_study_task8 in 2023
// Using Swift 5.0

import UIKit

class StorageService {
    
    var fileManager = FileManager()
    let tempDir = NSTemporaryDirectory()
    var cachedImagesFolderURL = URL(string: "") ?? URL(fileURLWithPath: "")
    
    func checkDirectory(name: String) -> Bool {
        var isExist = false
        let fileName = "\(name).png"
        do {
            let files = try fileManager.contentsOfDirectory(atPath: tempDir)
            if files.count > 0 {
                files.forEach {
                    if $0 == fileName {
                        isExist = true
                        print("file \(fileName) is exist")
                    }
                }
            }
        } catch let error as NSError {
            print(error)
        }
        
        return isExist
    }
    
    func createImage(image: UIImage, name: String) {
        let fileName = "\(name).png"
        let path = (tempDir as NSString).appendingPathComponent(fileName)
        let fileUrl = URL(fileURLWithPath: path)
            
        do {
            if let pngImageData = image.pngData() {
                try pngImageData.write(to: fileUrl, options: .atomic)
                print("File created at temp directory \(fileUrl)")
                
            }
        } catch let error as NSError {
            print("could't create file text.txt because of error: \(error)")
        }
    }
    
    func readImage(name: String) -> UIImage? {
        let fileName = "\(name).png"
        let path = (tempDir as NSString).appendingPathComponent(fileName)
        let url = URL(fileURLWithPath: path)
        
        do {
            let imageData = try Data(contentsOf: url)
            print("File with name \(fileName) is found")
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        
        return nil
    }
}

