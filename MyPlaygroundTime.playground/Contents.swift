import UIKit

var greeting = "Hello, playground"

//let targetDate = Date(timeIntervalSince1970: 1679669537)
//let currentDate = Date()
//let calendar = Calendar.current
//let targetHour = calendar.component(.hour, from: targetDate)
//let targetMinutes = calendar.component(.minute, from: targetDate)
//let targetSeconds = calendar.component(.second, from: targetDate)
//let currentHour = calendar.component(.hour, from: currentDate)
//let currentMinutes = calendar.component(.minute, from: currentDate)
//let currentSeconds = calendar.component(.second, from: currentDate)

//let diffs = Calendar.current.dateComponents([.hour, .minute, .second], from: currentDate, to: targetDate)

while true {
    sleep(1)
    let targetDate = Date(timeIntervalSince1970: 1679669537)
    let currentDate = Date()
    let time = Calendar.current.dateComponents([.hour, .minute, .second], from: currentDate, to: targetDate)
}
