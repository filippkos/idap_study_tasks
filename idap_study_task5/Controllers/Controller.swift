import Foundation

class Controller {
    
    // MARK: -
    // MARK: Variables
    
    let view = CarwashView()
    var cars = Atomic(wrappedValue: [Car]())
    var washers = [Washer]()
    
    let conQueue = DispatchQueue.global(qos: .background)

    let accountant = Accountant(name: "Bob")
    let director = Director(name: "Bill")
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init() {
        self.createWashers(maxNum: 2)
        self.accountant.moneyReceiver = self.director
        self.initWashers()
    }
    
    // MARK: -
    // MARK: Public ( Public visible funcs )
     
    func createWashers(maxNum: Int) {
        (0...Int.random(in: 1...maxNum)).forEach { _ in
            let washer = Washer(name: String.generate(letters: Alphabets.en.rawValue, maxRange: 3))
            washer.moneyReceiver = accountant
            washer.eventHandler = {event in
                switch event {
                    case .done:
                        self.process(washer: washer)
                }
            }
            self.washers.append(washer)
        }
    }
    
    func initWashers() {
        self.washers.forEach {
            $0.eventHandler?(.done)
        }
    }
    
    
    func process(washer: Washer) {
        self.conQueue.async {
            let car = self.cars.modify {
                return $0.removeFirst()
            }
            washer.action(object: car)
            self.view.printCarWashed(carId: car.id, name: washer.name)
            self.accountant.action(object: washer)
            self.view.printCountingDone(name: washer.name)
            self.view.printMoneyReceived(sum: self.director.money)
        }
    }
    
}
