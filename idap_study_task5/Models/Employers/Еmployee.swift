import Foundation

class Employee<Object>: MoneyContaibleProtocol, MoneyTransferProtocol {
    
    
    // MARK: -
    
    // MARK: Variables
    
    let name: String
    var state: EmployeeState
    var money: Int
    var experience: Double
    var salary: Int
    let price: Int
    weak var moneyReceiver: MoneyTransferProtocol?


    // MARK: -
    
    // MARK: Initializations and Deallocations
    
    init(name: String) {
        self.name = name
        self.state = .readyToWork
        self.money = 0
        self.experience = 1
        self.salary = 100
        self.price = 5
    }
    
    // MARK: -
    
    // MARK: Public ( Public visible funcs )
    
    func takeMoney<T: MoneyContaibleProtocol>(another: T) {
        var another = another
        self.money += price
        another.money -= price
    }
    
    func getMoney<T: MoneyTransferProtocol>(another: T) {
        takeMoney(another: another)
    }
    
    func action(object: Object) -> Bool {
        return true
    }
}
