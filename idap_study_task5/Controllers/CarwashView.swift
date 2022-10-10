import Foundation

class CarwashView {
    
    // MARK: -			
    // MARK: Public ( Public visible funcs )
    
    func printCountingDone() {
            print("counting done")
    }
    
    func printMoneyIsNotEnough() {
            print("money is not enough")
    }
    
    func printCarWashed(carId: Int, name: String) {
            print("car \(carId) washed by \(name)")
    }
    
    func printMoneyReceived(sum: Int) {
        print("Money received. Now its \(sum)")
    }
}
