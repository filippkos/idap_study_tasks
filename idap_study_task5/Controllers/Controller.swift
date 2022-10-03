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
    }
    
    // MARK: -
    
    // MARK: Public ( Public visible funcs )
     
    func createWashers(maxNum: Int) {
        (0...Int.random(in: 1...maxNum)).forEach { _ in
            let washer = Washer(name: String.generate(letters: Alphabets.en.rawValue, maxRange: 3))
            washer.moneyReceiver = accountant
            self.washers.append(washer)
        }
    }
    
    func process() {
        for washer in self.washers {
            if washer.state == .readyToWork {
                self.conQueue.async {
                    self.cars.modify {
                        if let car = $0.first(where: {$0.isClean == false}) {
                            if washer.action(object: car) {
                                self.view.printCarWashed(carId: car.id, name: washer.name)
                                $0.removeFirst()
                                self.accountant.action(object: washer)
                                self.view.printCountingDone(name: washer.name)
                                self.view.printMoneyReceived(sum: self.director.money)
                            }
                        }
                    }

                }
            }
        }
    }
    


}
