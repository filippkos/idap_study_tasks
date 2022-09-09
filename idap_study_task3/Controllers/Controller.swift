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
        self.washRooms = carwashBuilding.rooms
        self.createWashers()
        self.adminBuiding.rooms.first?.employeеs.append(contentsOf: [accountant, director])
    }
    
    func createWashers() {
        let names = ["bill", "bob", "bred", "boris", "bart"]
        for _ in 1...5 {
            self.washers.append(Washer(name: names.randomElement() ?? "unnamed"))
        }
    }
    
    func spreadCars() {
        self.washRooms.forEach { room in
            if room.car == nil && !cars.isEmpty {
                room.car = cars.first
                self.cars.removeFirst()
            }
        }
    }
    
    func spreadWashers() {
        self.washRooms.forEach { room in
            if room.car != nil && room.employeеs.isEmpty {
                if let washer = washers.first(where: { $0.inside == false }) {
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
                    let washer = wash(room: room)
                    handleTheMoney(washer: washer)
                    Thread.sleep(forTimeInterval: 0.2)
                }
            }
        }
    }
    
    func wash(room: WashingRoom) -> Washer {
        var result = Washer(name: "empty")
        if let car = room.car {
            if let washer = room.employeеs.first as? Washer {
                washer.wash(car: car)
                self.view.printCarWashed()
                room.car = nil
                room.employeеs.removeAll()
                washer.inside = false
                result = washer
            }
        }
        return result
    }
    
    func handleTheMoney(washer: Washer) {
        if self.accountant.count(washer: washer) {
            self.view.printEnoughMoney()
        } else {
            self.view.printMoneyIsNotEnough()
        }
        self.director.collect(accountant: accountant)
        self.view.printMoneyReceived()
    }
}

