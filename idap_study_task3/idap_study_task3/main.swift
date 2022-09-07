import Foundation

var cars = [Car]()
var controller: Controller

var i = 0
repeat {
    i += 1
    cars.append(Car(money: i * 10))
} while i < 10

controller = Controller(cars: cars)

controller.process()




