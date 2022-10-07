import Foundation

class Controller {
    
    // MARK: -
    // MARK: Variables
    
    let view = CarwashView()
    var cars = Atomic(wrappedValue: [Car]())
    var washers = [Washer]()
    
    let conQueue = DispatchQueue.global(qos: .background)
    let serQueue = DispatchQueue(label: "serQueue")

    let accountant = Accountant(name: "Bob")
    let director = Director(name: "Bill")
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init() {
        self.createWashers(maxNum: 2)
        self.accountant.moneyReceiver = self.director
    }
    
    // MARK: -
    // MARK: Public
     
    func createWashers(maxNum: Int) {
        (0...Int.random(in: 1...maxNum)).forEach { _ in
            let washer = Washer(name: String.generate(letters: Alphabets.en.rawValue, maxRange: 3))
            washer.moneyReceiver = accountant
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
    
    func initWashers() {
        washers.forEach {
            $0.eventHandler?(.readyToWork)
        }
    }
    
    func process(washer: Washer) {
        self.conQueue.async {
            if !self.cars.wrappedValue.isEmpty {
                let car = self.cars.modify {
                    $0.removeFirst()
                }
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
        self.serQueue.sync {
            self.accountant.action(object: moneyFrom)
            self.view.printCountingDone(name: moneyFrom.name)
            self.view.printMoneyReceived(sum: self.director.money)
        }
    }
}
