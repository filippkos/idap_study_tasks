import Foundation

class Woman: Creature {
    
    public init(name: String, age: Int) {
        super.init(name: name, age: age, gender: .female)
    }
    
    override func action() {
        print("I'm giving birth")
    }
}
