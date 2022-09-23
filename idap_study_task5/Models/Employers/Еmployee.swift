import Foundation

class Employee: MoneyContaible, MoneyTransferProtocol {
    
    let name: String
    var money: Int
    var experience: Double
    var salary: Int
    let price: Int
    weak var moneyReceiver: MoneyTransferProtocol?

    init(name: String) {
        self.name = name
        self.money = 0
        self.experience = 1
        self.salary = 100
        self.price = 5
    }
    
    func takeMoney<T: MoneyContaible>(another: T) {
        var another = another
        self.money += price
        another.money -= price
    }
    
    func getMoney<T: MoneyTransferProtocol>(another: T) {
        takeMoney(another: another)
    }

}
