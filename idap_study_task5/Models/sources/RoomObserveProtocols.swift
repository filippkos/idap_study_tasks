import Foundation

protocol RoomObserverProtocol {
    func updateWasherInRoom(room: WashingRoom)
    func updateCarInRoom(room: WashingRoom)
}

protocol RoomObservableProtocol {
    func add(observer: RoomObserverProtocol)
    func remove(observer: RoomObserverProtocol)
}
