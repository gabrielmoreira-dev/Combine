import UIKit
import Combine

let publisher = Just("Hello World")
let subscription = publisher.sink { print($0) }
subscription.cancel()
