import Foundation

class HumanViewController {
    var humans: Humans
    let view = HumansView()
    
    init(humans: Humans) {
        self.humans = humans
    }
    func process(current: Human, another: Human) {
        if current.isMarried == another.isMarried {
            let bothMarried = current.isMarried
            current.partner = current.isMarried ? nil : another
            current.isMarried = !current.isMarried
            current.numberOfLinks += current.isMarried ? -1 : 1
            another.partner = another.isMarried ? nil : current
            another.isMarried = !another.isMarried
            another.numberOfLinks += another.isMarried ? -1 : 1
            bothMarried == true ? view.printDivorceMessage(firstName: current.name, secondName: another.name)
            : view.printMarriageMessage(firstName: current.name, secondName: another.name)
        }
        
    }
        
    func procreate(current: Human, child: Human) {
        
        if !isDuplicated(current: current, child: child) {
            procreateOf(current: current, child: child)
            child.firstParent = current
            
            if let another = current.partner {
                procreateOf(current: another, child: child)
                child.secondParent = another
            }
            
        } else {
            self.view.printDuplicationOfChildrenMessage(name: current.name)
        }
    }
    
    func procreateOf(current: Human, child: Human) {
        if current.children.count < 20 {
            current.children.append(child)
            current.childrenQuantity += 1
            current.numberOfLinks += 1
            child.numberOfLinks += 1
            self.view.printProcreateMessage(name: current.name)
        } else {
            self.view.printChildrenLimitReaqchedMessage(name: current.name)
        }
    }
    
    func isDuplicated(current: Human, child: Human) -> Bool {
        for human in current.children {
            if human === child {
                return true
            }
        }
        return false
    }
    
}
