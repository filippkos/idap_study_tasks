import Foundation

class HumansView {

    func printMarriageMessage(firstName: String, secondName: String) {
        print("\(firstName) and \(secondName) just got married")
    }
    
    func printDivorceMessage(firstName: String, secondName: String) {
        print("\(firstName) and \(secondName) just got divorced")
    }
    
    func printProcreateMessage(name: String) {
            print("\(name) just had a child")
    }
    
    func printChildrenLimitReaqchedMessage(name: String) {
        print("maximum number of children reached (20) for \(name)")
    }
    
    func printDuplicationOfChildrenMessage(name: String) {
        print("\(name) already has this child")
    }
}
