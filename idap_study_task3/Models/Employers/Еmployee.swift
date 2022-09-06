import Foundation

class Employee {
    
    let name: String
    var personalFunds: Int
    var operaingFunds: Int
    var experience: Double
    var salary: Int

    init(name: String) {
        self.name = name
        self.personalFunds = 0
        self.operaingFunds = 0
        self.experience = 1
        self.salary = 100
    }
}
