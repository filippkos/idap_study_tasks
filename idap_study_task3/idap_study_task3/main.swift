import Foundation

var cars = [Car]()
var controller = Controller()

var i = 0
repeat {
    i += 1
    cars.append(Car(money: i * 10))
} while i < 10

controller.takecars(cars: cars)

controller.cars.forEach {
    print("car money: \($0.money)")
}

controller.process()

controller.cars.forEach {
    print("car money: \($0.money)")
}

print("washer's money: \(controller.washer.operaingFunds)")
print("accountant's money: \(controller.accountant.operaingFunds)")
print("director's money: \(controller.director.operaingFunds)")




