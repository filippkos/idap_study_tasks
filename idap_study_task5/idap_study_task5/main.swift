import Foundation

// MARK: -
// MARK: Variables

let controller = Controller()
var idCounter = 0

while true {
    idCounter += 1
    let car = Car(id: idCounter, money: idCounter * 10)
    controller.cars.modify { $0.append(car) }
    if idCounter == controller.washers.count {
        controller.initWashers()
    }
    sleep(UInt32.random(in: 0..<1))
}
