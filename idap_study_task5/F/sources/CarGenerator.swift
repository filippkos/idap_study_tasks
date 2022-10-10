import Foundation

class CarGenerator {
    
    // MARK: -
    // MARK: Variables
    
    var idCounter = 0
    var handler: (Car) -> ()
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init(handler: @escaping (Car) -> ()) {
        self.handler = handler
    }
    
    // MARK: -
    // MARK: Public
    
    public func start() {
        while true {
            idCounter += 1
            let car = Car(id: idCounter, money: idCounter * 10)
            self.handler(car)
            sleep(UInt32.random(in: 0..<1))
        }
    }
}
