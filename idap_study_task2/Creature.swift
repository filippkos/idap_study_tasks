import Foundation

enum Gender {
    
    case male
    case female
}

class Creature {
    
    var name: String
    var age: Int
    var gender: Gender
    var children = Creatures()
    
    init(name: String, age: Int, gender: Gender) {
        self.name = name
        self.age = age
        self.gender = gender
    }
    
    func sayHello() {
        print("Hello!")
        for child in self.children {
            child.sayHello()
        }
    }
    
    func action() {
        
    }
}
