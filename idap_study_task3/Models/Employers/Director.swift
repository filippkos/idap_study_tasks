import Foundation

class Director: Employee {
    
    override init(name: String) {
        super.init(name: name)
    }
    
    func collect(accountant: Accountant) {
        super.takeMoney(another: accountant)
    }
}
