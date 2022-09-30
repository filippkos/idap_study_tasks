import Foundation

class Director: Employee<Accountant> {
    
    // MARK: -
    
    // MARK: Initializations and Deallocations
    
    override init(name: String) {
        super.init(name: name)
    }
    
    override func action(object: Accountant) -> Bool {
        return true
    }
}
