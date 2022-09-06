import Foundation

protocol AbleToPlaceCar {
    
    var cars: [Car] { get }
}

class WashingRoom: Room, AbleToPlaceCar {
    
    var cars: [Car]
        
    override init() {
        self.cars = [Car]()
    }
    
    func washCar(washer: Washer, car: Car) {
        washer.wash(car: car)
    }
}
