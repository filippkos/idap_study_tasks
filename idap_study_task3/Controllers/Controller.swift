import Foundation

class Controller {
    
    let view = CarwashView()
    
    let adminBuiding = AdministrationBuilding()
    let carwashBuilding = CarwashBuilding()
    
    var cars = [Car]()
    var washers = [Washer]()
    var washRooms: [WashingRoom]
    
    let accountant = Accountant(name: "Bob")
    let director = Director(name: "Bill")
    
    init(cars: [Car]) {
        self.cars = cars
        self.washRooms = self.carwashBuilding.rooms
        self.createWashers()
        self.adminBuiding.rooms.first?.employeеs.append(contentsOf: [accountant, director])
    }
    
    func createWashers() {
        (0...5).forEach { _ in self.washers.append(Washer(name: String.generate())) }
    }
    
    func spreadCars() {
        self.washRooms.forEach { room in
            if room.car == nil && !self.cars.isEmpty {
                room.car = self.cars.first
                self.cars.removeFirst()
            }
        }
    }
    
    func spreadWashers() {
        self.washRooms.forEach { room in
            if room.car != nil && room.employeеs.isEmpty {
                if let washer = self.washers.first(where: { $0.inside == false }) {
                    washer.inside = true
                    room.employeеs.append(washer)
                }
            }
        }
    }
    
    func process() {
        while !cars.isEmpty {
            self.spreadCars()
            self.spreadWashers()
            self.washRooms.forEach { room in
                if room.car != nil && room.employeеs.count == 1 {
                    let washer = self.process(room: room)
                    washer.map(self.handleMoney)
                    Thread.sleep(forTimeInterval: 0.2)
                }
            }
        }
    }
    
    func process(room: WashingRoom) -> Washer? {
        let car = room.car
        let washer = room.employeеs.first
        
        car.map { washer?.wash(car: $0) }
        self.view.printCarWashed(name: washer?.name ?? "")
        room.car = nil
        room.employeеs.removeAll()
        washer?.inside = false

        return washer
    }
    
    func handleMoney(washer: Washer) {
        if self.accountant.count(washer: washer) {
            self.view.printEnoughMoney()
        } else {
            self.view.printMoneyIsNotEnough()
        }
        self.director.collect(accountant: accountant)
        self.view.printMoneyReceived()
    }
}

