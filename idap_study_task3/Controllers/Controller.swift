import Foundation

class Controller {
    
    var cars = [Car]()
    
    let adminBuiding = AdministrationBuilding()
    let carWashBuilding = CarwashBuilding()
    
    var adminRoom: Room { adminBuiding.rooms[0] }
    var carwashRoom: WashingRoom { carWashBuilding.rooms[0] }
    
    let accountant = Accountant(name: "Bob")
    let washer = Washer(name: "Brian")
    let director = Director(name: "Barry")
    
    init() {
        self.carwashRoom.employeеs.append(washer)
        self.adminRoom.employeеs.append(accountant)
        self.adminRoom.employeеs.append(director)
    }
    
    func takecars(cars: [Car]) {
        cars.forEach { car in
            self.cars.append(car)
        }
    }
    
    func process() {
        self.cars.map { car in
            
            self.carwashRoom.washCar(washer: washer, car: car)
            self.adminRoom.countMoney(accountant: accountant, washer: washer)
            self.adminRoom.takeMoney(director: director, accountant: accountant)

            Thread.sleep(forTimeInterval: 0.1)
        }
    }
}

