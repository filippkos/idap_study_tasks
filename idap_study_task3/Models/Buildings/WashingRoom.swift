import Foundation

protocol AbleToPlaceCar {
    
    var car: Car? { get }
}

class WashingRoom: Room, AbleToPlaceCar {
    
    var car: Car?
        
    override init() {
        self.car = nil
    }
}
