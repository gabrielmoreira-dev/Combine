import Combine
import Foundation

let publisher = Timer.publish(every: 1, on: .main, in: .common)
let subscription = publisher.autoconnect().sink { print($0) }
