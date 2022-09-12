import Foundation

protocol AbleToPlaceCar {
    
    var car: Car? { get set }
}

class WashingRoom: Room<Washer>, AbleToPlaceCar {
    
    var car: Car?
        
    override init() {
        self.car = nil
    }
}
