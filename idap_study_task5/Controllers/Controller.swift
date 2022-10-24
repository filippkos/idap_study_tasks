import Foundation

class Controller {
    
    // MARK: -
    // MARK: Variables
    
    let view = CarwashView()
    var cars = Atomic(wrappedValue: [Car]())
    var washers = [Washer]()
    let accountants = Atomic(wrappedValue: [Accountant]())
    let director = Director(name: "Bill")
    var idCounter = 0
    
    let conQueue = DispatchQueue.global(qos: .background)
    let serQueue = DispatchQueue(label: "serQueue")

    // MARK: -
    // MARK: Initializations and Deallocations
    
    init() {
        self.createWashers(maxNum: 2)
        self.createAccountants(maxNum: 2)
        self.director.eventHandler = { [weak self] event in
            switch event {
                case .readyToWork:
                    return
                case .working:
                    return
                case .needsProcessing:
                    if let director = self?.director {
                        self?.view.printMoneyReceived(sum: director.money)
                    }
            }
        }
    }
    
    // MARK: -
    // MARK: Public
     
    func createWashers(maxNum: Int) {
        (0...Int.random(in: 1...maxNum)).forEach { _ in
            let washer = Washer(name: String.generate(letters: Alphabets.en.rawValue, maxRange: 3))
            washer.eventHandler = { [weak self] event in
                switch event {
                    case .readyToWork:
                        self?.process(washer: washer)
                    case .working:
                        return
                    case .needsProcessing:
                        self?.process(moneyFrom: washer)
                }
            }
            self.washers.append(washer)
        }
    }
    
    func createAccountants(maxNum: Int) {
        (0...Int.random(in: 1...maxNum)).forEach { _ in
            let accountant = Accountant(name: String.generate(letters: Alphabets.en.rawValue, maxRange: 3))
            accountant.eventHandler = { [weak self] event in
                switch event {
                    case .readyToWork:
                        return
                    case .working:
                        return
                    case .needsProcessing:
                    self?.view.printCountingDone(name: accountant.name)
                        self?.serQueue.sync {
                            if let director = self?.director {
                                director.action(object: accountant)
                            }
                        }
                }
            }
            self.accountants.modify {
                $0.append(accountant)
            }
        }
    }
    
    func initWashers() {
        washers.forEach {
            $0.eventHandler?(.readyToWork)
        }
    }
    
    func process(washer: Washer) {
        self.conQueue.async {
            let car = self.cars.modify {
                $0.isEmpty ? nil : $0.removeFirst()
            }
            if let car = car {
                car.eventHandler = { [weak self] event in
                    switch event {
                        case true:
                            self?.view.printCarWashed(carId: car.id, name: washer.name)
                        case false:
                            return
                    }
                }
                washer.action(object: car)
            }
        }
    }
    
    func process(moneyFrom: Washer) {
        self.conQueue.async {
            let accountant = self.accountants.modify {
                $0.first(where: { $0.state == .readyToWork })
            }
            if let accountant = accountant {
                accountant.action(object: moneyFrom)
            }
        }
    }
    
    func process(car: Car) {
        while true {
            self.idCounter += 1
            let car = Car(id: idCounter, money: idCounter * 10)
            self.cars.modify { $0.append(car) }
            if self.idCounter == self.washers.count {
                self.initWashers()
            }
            sleep(UInt32.random(in: 0..<1))
        }
    }
}
