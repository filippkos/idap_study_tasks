import Foundation

class Man: Creature {
    
    public init(name: String, age: Int) {
        super.init(name: name, age: age, gender: .male)
    }
    
    override func action() {
        print("I fight")
    }
}
