import Foundation

class Controller {
    
    var cars = [Car]()
    
    let adminBuiding = AdministrationBuilding()
    let carWashBuilding = CarwashBuilding()
    
    let accountant = Accountant(name: "Bob")
    let washer = Washer(name: "Brian")
    let director = Director(name: "Barry")
    
    init() {
        
    }
    
    func takecars(cars: [Car]) {
        cars.forEach { car in
            self.cars.append(car)
        }
    }
    
    
    func process() {
        self.cars.forEach { car in
            
            self.washer.wash(car: car)
            self.accountant.count(washer: washer)
            self.director.collect(accountant: accountant)

            Thread.sleep(forTimeInterval: 0.1)
        }
    }
}

