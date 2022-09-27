import Foundation

class WashingRoom: Room<Washer>, AbleToPlaceCarProtocol, RoomObservableProtocol {
    
    // MARK: Variables
    var observer: RoomObserverProtocol?
    var car: Car? {
        didSet {
            if self.car == nil {
                self.observer?.updateCarInRoom(room: self)
            }
            if self.car != nil && self.employeеs.count == 0 {
                self.observer?.updateWasherInRoom(room: self)
            }
        }
    }
    
    // MARK: Initializations and Deallocations
    override init() {
        self.observer = nil
        self.car = nil
    }
    
    // MARK: Public ( Public visible funcs )
    func add(observer: RoomObserverProtocol) {
        self.observer = observer
    }
    
    func remove(observer: RoomObserverProtocol) {
        self.observer = nil
    }
}
