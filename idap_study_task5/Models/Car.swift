import Foundation

class Car: MoneyContaibleProtocol {
    
    // MARK: -
    // MARK: Variables
    
    var id: Int
    var money: Int
    var isClean: Bool {
        didSet {
            self.eventHandler?(self.isClean)
        }
    }
    var time: UInt32
    var eventHandler: ((Bool) -> ())?
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init(id: Int, money: Int) {
        self.id = id
        self.money = money
        self.isClean = false
        self.time = UInt32.random(in: 1...3)
    }
}
