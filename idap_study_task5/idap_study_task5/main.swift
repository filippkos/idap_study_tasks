import Foundation 

// MARK: -
// MARK: Variables

let controller = Controller()
let generator = CarGenerator(handler: { [weak controller] in
    controller?.process(car: $0)
})

generator.start()

  
