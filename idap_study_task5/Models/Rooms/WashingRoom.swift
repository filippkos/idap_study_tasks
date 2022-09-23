import Foundation

protocol AbleToPlaceCar {
    
    var car: Car? { get set }
}

class WashingRoom: Room<Washer>, AbleToPlaceCar, RoomObservable {
    
    var observer: RoomObserver?
    
    var car: Car? {
        didSet {
            if self.car == nil {
                notifyObservers()
            }
        }
    }
    
    func add(observer: RoomObserver) {
        self.observer = observer
    }
    
    func remove(observer: RoomObserver) {
        self.observer = nil
    }
    
    func notifyObservers() {
            observer?.updateRoom(room: self)
    }
    
    override init() {
        self.observer = nil
        self.car = nil
    }
}
