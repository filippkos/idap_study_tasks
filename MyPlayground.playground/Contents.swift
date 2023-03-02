import UIKit

var greeting = "Hello, playground"

let state = UIControl.State.selected
let stateTwo = UIControl.State.disabled

let result: UIControl.State = [state]
result.contains(.selected)
result.contains(.normal)
result.contains(.disabled)
result.contains([state, stateTwo])
