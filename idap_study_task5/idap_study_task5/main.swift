import Foundation

// MARK: Variables
let controller = Controller()
var idCounter = 0

while true {
    idCounter += 1
    controller.cars.append(Car(id: idCounter, money: idCounter * 10))
    controller.process()
    sleep(UInt32.random(in: 1..<3))
}






