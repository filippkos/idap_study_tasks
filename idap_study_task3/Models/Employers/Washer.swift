import Foundation

class Washer: Employee {
    
    let view = CarwashView()
    let price = 5
    
    override init(name: String) {
        super.init(name: name)
    }
    
    func wash(car: Car) {
        if (car.money >= price) {
            car.isClean = true
            car.money -= price
            self.operaingFunds += price
            self.view.printCarWashed()
        } else {
            self.view.printMoneyIsNotEnough()
        }
    }
}
