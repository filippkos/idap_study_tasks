import Foundation

class Accountant: Employee, EmployeeStateProtocol {
    
    var state: EmployeeState
    
    let lock = NSLock()
    override var money: Int {
        didSet {
            if self.money - oldValue == price {
                self.lock.lock()
                if self.action() {
                    self.moneyReceiver?.getMoney(another: self)
                }
                self.lock.unlock()
            }
        }
    }

    override init(name: String) {
        self.state = .readyToWork
        super.init(name: name)
    }
    
    func action() -> Bool {
        sleep(1)
        let isEnough = self.money >= self.price
        return isEnough
    }
}
