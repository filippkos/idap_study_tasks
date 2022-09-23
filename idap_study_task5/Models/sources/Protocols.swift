import Foundation

enum EmployeeState {
    case readyToWork
    case working
    case needsProcessing
}

protocol EmployeeStateProtocol {
    var state: EmployeeState { get set }
}

protocol MoneyContaible {
    var money: Int { get set }
}

protocol MoneyTransferProtocol: AnyObject, MoneyContaible {
    func getMoney<T: MoneyTransferProtocol>(another: T)
}

protocol RoomObservable {
    func add(observer: RoomObserver)
    func remove(observer: RoomObserver)
    func notifyObservers()
}

protocol RoomObserver {
    func updateRoom(room: WashingRoom)
}
