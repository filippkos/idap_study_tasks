import UIKit

var greeting = "Hello, playground"

func parseSuccess(number: Int) throws -> String {
    if number == 1 {
        return "success"
    } else {
        throw NSError(domain: "test", code: 100)
    }
}

func parseError(number: Int) -> String? {
    if number == 0 {
        return "error"
    } else {
        return nil
    }
}

let number = 10

do {
   let response = try parseSuccess(number: number)
    print(response)
} catch let decodingError {
    if let response = parseError(number: number) {
        print(response)
    } else {
        print(decodingError)
    }
}
