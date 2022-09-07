import Foundation

class Accountant: Employee {
    
    override init(name: String) {
        super.init(name: name)
    }
    
    func count(washer: Washer) {
        super.takeMoney(another: washer)
    }
}
