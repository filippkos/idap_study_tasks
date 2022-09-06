import Foundation

class Accountant: Employee {
    
    let view = CarwashView()
    let price = 5
    
    override init(name: String) {
        super.init(name: name)
    }
    
    func count(washer: Washer) {
        if (washer.operaingFunds >= price) {
            washer.operaingFunds -= price
            self.operaingFunds += price
            self.view.printEnoughMoney()
        } else {
            self.view.printMoneyIsNotEnough()
        }
    }
}
