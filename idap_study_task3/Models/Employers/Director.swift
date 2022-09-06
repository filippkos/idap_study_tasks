import Foundation

class Director: Employee {
    
    let view = CarwashView()
    let price = 5
    
    override init(name: String) {
        super.init(name: name)
    }
    
    func collect(accountant: Accountant) {
        self.operaingFunds += price
        accountant.operaingFunds -= price
        self.view.printMoneyReceived()
    }
}
