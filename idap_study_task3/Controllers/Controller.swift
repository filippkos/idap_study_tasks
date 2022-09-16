import Foundation

class Controller {
    
    let view = CarwashView()
    
    var cars = [Car]()
    var washers = [Washer]()
    var washRooms = [WashingRoom]()
    var adminRoom = Room<Employee>()
    
    let accountant = Accountant(name: "Bob")
    let director = Director(name: "Bill")
    
    init(cars: [Car]) {
        self.cars = cars
        self.createWashrooms(number: 2)
        self.createWashers()
        self.adminRoom.employeеs.append(contentsOf: [self.accountant, self.director])
        self.accountant.moneyReceiver = self.director
    }
    
    func createWashrooms(number: Int) {
        (1...number).forEach { _ in self.washRooms.append(WashingRoom())}
    }
    
    func createWashers() {
        (0...Int.random(in: 1...5)).forEach { _ in
            let washer = Washer(name: String.generate(letters: Alphabets.en.rawValue, maxRange: 3))
            washer.moneyReceiver = accountant
            self.washers.append(washer) }
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
                if let washer = self.washers.first(where: { $0.inside == false })
                {
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
                    Thread.sleep(forTimeInterval: 0.2)
                }
            }
        }
    }
    
    func process(room: WashingRoom) -> Washer? {
        
        let car = room.car
        let washer = room.employeеs.first
        
        car.map { washer?.action(car: $0) }
        self.view.printCarWashed(name: washer?.name ?? "")
        room.car = nil
        room.employeеs.removeAll()
        washer?.inside = false
        return washer
    }
}

