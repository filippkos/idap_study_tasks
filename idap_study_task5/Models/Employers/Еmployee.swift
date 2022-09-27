import Foundation

class Employee: MoneyContaibleProtocol, MoneyTransferProtocol {
    
    // MARK: Variables
    let name: String
    var money: Int
    var experience: Double
    var salary: Int
    let price: Int
    weak var moneyReceiver: MoneyTransferProtocol?

    // MARK: Initializations and Deallocations
    init(name: String) {
        self.name = name
        self.money = 0
        self.experience = 1
        self.salary = 100
        self.price = 5
    }
    
    // MARK: Public ( Public visible funcs )
    func takeMoney<T: MoneyContaibleProtocol>(another: T) {
        var another = another
        self.money += price
        another.money -= price
    }
    
    func getMoney<T: MoneyTransferProtocol>(another: T) {
        takeMoney(another: another)
    }
}
