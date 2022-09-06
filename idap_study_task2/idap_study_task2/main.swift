import Foundation

let names = [("alex", Gender.male), ("bob", Gender.male), ("john", Gender.male), ("anna", Gender.female), ("maria", Gender.female), ("kate", Gender.female), ("dave", Gender.male), ("joe", Gender.male), ("mike", Gender.male), ("kelly", Gender.female), ("alice", Gender.female), ("grace", Gender.female)]
let age = [23, 34, 22, 44, 43, 32, 12, 10, 11, 13, 8, 9]

let humans = zip(names, age)
    .map {
        creature(gender: $0.1, name: $0.0, age: $1)
    }

let parents = humans.filter { $0.age >= 18 }
let children = humans.filter { $0.age < 18 }

func creature(gender: Gender, name: String, age: Int) -> Creature {
    switch gender {
    case .male:
        return Man(name: name, age: age)
    case .female:
        return Woman(name: name, age: age)
    }
}

zip(parents, children).forEach {$0.0.children.append($0.1)}

parents.forEach { creature in
    creature.action()
}

parents.forEach { creature in
    print("\(creature.name) has a child named: \(creature.children[0].name)")
}
