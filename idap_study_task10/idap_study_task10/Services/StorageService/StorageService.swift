//
//  StorageService.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

protocol StorageServiceType {
    
    var fileManager: FileManager { get }
    var directory: String { get }
    var cachedImagesFolderURL: URL? { get }
    
    
    func checkDirectory(name: String, completion: @escaping F.ResultHandler<UIImage?>)
    func readImage(name: String) -> UIImage?
    func checkAndCreateDirectory()
    func createImage(image: UIImage, name: String)
}

final class StorageService: StorageServiceType {
    
    // MARK: -
    // MARK: Variables
    
    var fileManager = FileManager()
    var directory = NSTemporaryDirectory()
    var cachedImagesFolderURL: URL?
    let folderName = "cachedImages"
    
    init() {
        self.checkAndCreateDirectory()
        self.directory = self.trim(url: String(((self.cachedImagesFolderURL)?.absoluteString ?? "")))
    }
    
    // MARK: -
    // MARK: Public
    
    public func checkDirectory(name: String, completion: @escaping F.ResultHandler<UIImage?>) {
        let fileName = "\(name).\(self.getFileFormat(from: name))"
        
        do {
            var isFound = false
            let files = try fileManager.contentsOfDirectory(atPath: self.directory)
            if files.count > 0 {
                files.forEach {
                    if $0 == fileName {
                        isFound = true
                        completion(.success(self.readImage(name: name)))
                    }
                }
                if isFound == false {
                    completion(.success(nil))
                }
            } else {
                completion(.success(nil))
            }
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
    
    public func readImage(name: String) -> UIImage? {
        let fileName = "\(name).\(self.getFileFormat(from: name))"
        let path = (self.directory as NSString).appendingPathComponent(fileName)
        let url = URL(fileURLWithPath: path)
        
        do {
            let imageData = try Data(contentsOf: url)
            print("<@> File with name \(fileName) is found")
            return UIImage(data: imageData)
        } catch {
            print("Error loading image: \(error)")
        }
        
        return nil
    }
    
    public func checkAndCreateDirectory() {
        
        self.fileManager = FileManager.default
        self.cachedImagesFolderURL = try? self.fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(folderName)
        
        do {
            if let url = self.cachedImagesFolderURL {
                try? self.fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
                
            }
        }
    }
    
    public func createImage(image: UIImage, name: String) {
        let fileName = "\(name).\(self.getFileFormat(from: name))"
        let path = (directory as NSString).appendingPathComponent(fileName)
        let fileUrl = URL(fileURLWithPath: path)
            
        do {
            if let pngImageData = image.pngData() {
                try pngImageData.write(to: fileUrl, options: .atomic)
                print("<@> File created at temp directory \(fileUrl)")
                
            }
        } catch let error as NSError {
            print("could't create file text.txt because of error: \(error)")
        }
    }
    
    // MARK: -
    // MARK: Internal
    
    internal func getFileFormat(from name: String) -> String {
        let range = NSRange(location: 0, length: name.utf16.count)
        let regex = try? NSRegularExpression(pattern: "[a-z](\\w+)$")
        let result = regex?.firstMatch(in: name, range: range)
        return (result.map { String(name[Range($0.range, in: name)!]) })?.description ?? ""
    }
    
    internal func trim(url: String) -> String {
        let range = NSRange(location: 0, length: url.utf16.count)
        let regex = try? NSRegularExpression(pattern: "(\\w+.//)")
        let result = regex?.firstMatch(in: url, range: range)
        let substring = (result.map { String(url[Range($0.range, in: url)!]) })?.description ?? ""
        return url.replacingOccurrences(of: substring, with: "")
    }
}
