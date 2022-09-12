import Foundation

let cars = (0...15).map { Car(money: $0 * 10) }
let controller: Controller

controller = Controller(cars: cars)
controller.process()
