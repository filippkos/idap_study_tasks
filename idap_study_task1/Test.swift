import Foundation

class Test {
    
    var humans = Humans()

    func start() {
        let firstHuman = Human(name: "first_test_name", age: 0, gender: .male)
        let secondHuman = Human(name: "second_test_name", age: 0, gender: .female)
        let thirdHuman = Human(name: "third_test_name", age: 0, gender: .male)
        
        humans.append(firstHuman)
        humans.append(secondHuman)
        humans.append(thirdHuman)
        
        let controller = HumanViewController(humans: humans)
        
        
        if humans.count == 3 {
            print("init method is OK")
        } else {
            print("something wrong with init function")
        }
        
        marryTest(humans: humans, controller: controller)
        procreateTest(humans: humans, controller: controller)
        divorceTest(humans: humans, controller: controller)
    }
    
    func marryTest(humans: Humans, controller: HumanViewController) {
        let firstHuman = humans[0]
        let secondHuman = humans[1]
        controller.process(current: firstHuman, another: secondHuman)
        if firstHuman.partner === secondHuman && secondHuman.partner === firstHuman
        {
            print ("partner field in marriage is OK")
        } else {
            print("something wrong with marry function (partner field)")
        }
        if firstHuman.isMarried == true && secondHuman.isMarried == true
        {
            print ("isMarried field in marriage is OK")
        } else {
            print("something wrong with marry function (isMarried field)")
        }
        if firstHuman.numberOfLinks == 1 && secondHuman.numberOfLinks == 1
        {
            print ("links field in marriage is OK")
        } else {
            print("something wrong with marry function (links field)")
        }
    }
    
    func procreateTest(humans: Humans, controller: HumanViewController) {
        let firstHuman = humans[0]
        let secondHuman = humans[1]
        let child = humans[2]
        controller.procreate(current: firstHuman, child: child)
        if child.firstParent === firstHuman && child.secondParent === secondHuman
        {
            print("parents fields in procreate function is OK")
        } else {
            print("something wrong with marry function (parents field)")
        }
        if firstHuman.children[0] === child && secondHuman.children[0] === child
        {
            print("children field in procreate function is OK")
        } else {
            print("something wrong with procreate function (children field)")
        }
        if child.numberOfLinks == 2 {
            print("links fields in procreate function is OK")
        } else {
            print("something wrong with marry function (links field)")
        }
    }
    
    
    func divorceTest(humans: Humans, controller: HumanViewController) {
        let firstHuman = humans[0]
        let secondHuman = humans[1]
        let child = humans[2]
        controller.process(current: firstHuman, another: secondHuman)
        if firstHuman.partner === nil && secondHuman.partner === nil
        {
            print ("partner field in divorce is OK")
        } else {
            print("something wrong with divorce function (partner field)")
        }
        if firstHuman.numberOfLinks == 1 && secondHuman.numberOfLinks == 1
        {
            print ("parents links field in divorce is OK")
        } else {
            print("something wrong with divorce function (parents links field)")
        }
        if firstHuman.isMarried == false && secondHuman.isMarried == false
        {
            print ("isMarried field in divorce is OK")
        } else {
            print("something wrong with divorce function (isMarried field)")
        }
        if child.numberOfLinks == 2 {
            print("child links field in divorce function is OK")
        } else {
            print("something wrong with divorce function (child links field)")
        }
        if child.firstParent === firstHuman && child.secondParent === secondHuman
        {
            print("parents fields in divorce function is OK")
        } else {
            print("something wrong with divorce function (parents field)")
        }
    }
}
