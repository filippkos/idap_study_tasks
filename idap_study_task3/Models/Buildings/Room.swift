import Foundation

class Room {
    
    var employeеs = [Employee]()
    
    func countMoney(accountant: Accountant, washer: Washer) {
        accountant.count(washer: washer)
    }
    
    func takeMoney(director: Director, accountant: Accountant) {
        director.collect(accountant: accountant)
    }
}
