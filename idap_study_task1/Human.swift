import Foundation

enum Gender {
    case male ,female
}

class Human {
    var name: String
    var age: Int?
    var gender: Gender
    
    var childrenQuantity = 0
    var isMarried = false
    
    var partner: Human?
    var firstParent: Human?
    var secondParent: Human?
    var children = Humans()
    
    var numberOfLinks = 0
    
    init(name: String, age: Int, gender: Gender) {
        self.name = name
        self.age = age
        self.gender = gender
    }
}
