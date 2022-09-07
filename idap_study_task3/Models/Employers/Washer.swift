import Foundation

class Washer: Employee {
    
    override init(name: String) {
        super.init(name: name)
    }
    
    func wash(car: Car) {
        car.isClean = true
        super.takeMoney(another: car)
    }
}
