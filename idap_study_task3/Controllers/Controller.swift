import Foundation

class Controller {
    
    var cars = [Car]()
    let view = CarwashView()
    
    let adminBuiding = AdministrationBuilding()
    let carwashBuilding = CarwashBuilding()
    var washRooms: [WashingRoom]
    
    let accountant = Accountant(name: "Bob")
    let washer = Washer(name: "Brian")
    let director = Director(name: "Bill")
    
    init(cars: [Car]) {
        self.cars = cars
        self.washRooms = carwashBuilding.rooms
    }
    
    func spreadCars() {
        self.washRooms.forEach { room in
            if room.car == nil && !cars.isEmpty {
                room.car = cars.first
                self.cars.removeFirst()
            }
        }
    }
    
    func process() {
        while !cars.isEmpty {
            self.spreadCars()
            self.washRooms.forEach { room in
                if let car = room.car {
                    self.washer.wash(car: car)
                    self.view.printCarWashed()
                    room.car = nil
                }
                if self.accountant.count(washer: washer) {
                    self.view.printEnoughMoney()
                } else {
                    self.view.printMoneyIsNotEnough()
                }
                self.director.collect(accountant: accountant)
                self.view.printMoneyReceived()
                Thread.sleep(forTimeInterval: 0.2)
                
            }
        }
    }
}

