import Combine
import Foundation

public final class TimerPublisher {
    public static func execute() {
        let publisher = Timer.publish(every: 1, on: .main, in: .common)
        let subscription = publisher.autoconnect().sink { print($0) }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            subscription.cancel()
        }
    }
}
