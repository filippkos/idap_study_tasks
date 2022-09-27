import Foundation

enum EmployeeState {
    case free
    case readyToWork
    case working
    case needsProcessing
}

protocol EmployeeStateProtocol {
    var state: EmployeeState { get set }
}
