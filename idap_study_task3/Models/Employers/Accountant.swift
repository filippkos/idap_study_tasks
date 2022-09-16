import Foundation

class Accountant: Employee {
    
    override var money: Int {
        didSet {
            if self.money - oldValue == price {
                if self.action() {
                    self.moneyReceiver?.getMoney(another: self)
                }
            }
        }
    }

    override init(name: String) {
        super.init(name: name)
    }
    
    func action() -> Bool {
        let isEnough = self.money >= self.price
        return isEnough
    }
}
