import Foundation

class Controller: RoomObserver {
        
    let view = CarwashView()
    var cars = [Car]()
    var washers = [Washer]()
    var washRooms = [WashingRoom]()
    var adminRoom = Room<Employee>()
    
    let conQueue = DispatchQueue.global(qos: .background)

    let accountant = Accountant(name: "Bob")
    let director = Director(name: "Bill")
    
    init(cars: [Car]) {
        self.cars = cars
        self.createWashrooms(number: 2)
        self.createWashers()
        self.spreadCars()
        self.adminRoom.employeеs.append(contentsOf: [self.accountant, self.director])
        self.accountant.moneyReceiver = self.director
    }
    
    func createWashrooms(number: Int) {
        (1...number).forEach { _ in
            let washRoom = WashingRoom()
            washRoom.add(observer: self)
            self.washRooms.append(washRoom)
        }
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
    
    func updateRoom(room: WashingRoom) {
        room.car = self.cars.first
        self.cars.removeFirst()
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
        while !self.cars.isEmpty {
            self.spreadWashers()
            self.washRooms.forEach { room in
                self.conQueue.async {
                    if room.car != nil && room.employeеs.count == 1 {
                        self.process(room: room)
                    }
                }
            }
        }
    }
    
    func process(room: WashingRoom) {
        
        let car = room.car
        let washer = room.employeеs.first
        car.map { washer?.action(car: $0) }
        self.view.printCarWashed(name: washer?.name ?? "")
        room.car = nil
        room.employeеs.removeAll()
        washer?.inside = false
    }
}

