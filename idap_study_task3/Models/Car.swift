import Foundation

class Car: MoneyContaible {
    
    var money: Int
    var isClean: Bool
    
    init(money: Int) {
        self.money = money
        self.isClean = false
    }
}
