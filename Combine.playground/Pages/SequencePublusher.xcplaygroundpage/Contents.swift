import Combine

let publisher = [1, 2, 3, 4, 5, 6].publisher
let publisher2 = publisher.map { $0 * 2 }
let subscription = publisher2.sink { print($0) }
