import Foundation

class Controller: RoomObserverProtocol {
    
    // MARK: Variables
    let view = CarwashView()
    var cars = [Car]() {
        didSet {
            if !isInit && self.cars.count == washRooms.count {
                spreadCars()
                isInit = true
            }
        }
    }
    
    var isInit = false
    var washers = [Washer]()
    var washRooms = [WashingRoom]()
    var adminRoom = Room<Employee>()
    
    let conQueue = DispatchQueue.global(qos: .background)

    let accountant = Accountant(name: "Bob")
    let director = Director(name: "Bill")
    
    // MARK: Initializations and Deallocations
    init() {
        self.createWashrooms(number: 2)
        self.createWashers(maxNum: 2)
        self.adminRoom.employeеs.append(contentsOf: [self.accountant, self.director])
        self.accountant.moneyReceiver = self.director
    }
    
    // MARK: Public ( Public visible funcs )
    func createWashrooms(number: Int) {
        (1...number).forEach { _ in
            let washRoom = WashingRoom()
            washRoom.add(observer: self)
            self.washRooms.append(washRoom)
        }
    }
     
    func createWashers(maxNum: Int) {
        (0...Int.random(in: 1...maxNum)).forEach { _ in
            let washer = Washer(name: String.generate(letters: Alphabets.en.rawValue, maxRange: 3))
            washer.moneyReceiver = accountant
            self.washers.append(washer)
        }
    }
    
    func spreadCars() {
        self.washRooms.forEach { room in
            if room.car == nil && !self.cars.isEmpty {
                room.car = self.cars.first
                self.cars.removeFirst()
            }
        }
    }
    
    func updateCarInRoom(room: WashingRoom) {
        room.car = self.cars.first
        self.cars.removeFirst()
    }
    
    func updateWasherInRoom(room: WashingRoom) {
        if let washer = self.washers.first(where: { $0.state == .free })
        {
            washer.state = .readyToWork
            room.employeеs.append(washer)
        }
    }
    
    func process() {
            for room in self.washRooms {
                //print(room.car?.id, room.employeеs.count, room.car?.isClean, room.employeеs.first?.state)
                self.conQueue.async {
                if room.car != nil && room.employeеs.count == 1 && room.employeеs.first?.state == .readyToWork
                {
                    room.employeеs.first?.state = .working
                    self.process(room: room)
                }
            }
        }
    }
    
    func process(room: WashingRoom) {
        let car = room.car
        let washer = room.employeеs.first
        car.map { washer?.action(car: $0) }
        room.employeеs.removeAll()
        room.car = nil
    }
}

