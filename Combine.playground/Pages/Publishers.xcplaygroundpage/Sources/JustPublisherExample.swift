import Combine

public final class JustPublisherExample {
    public static func execute() {
        let publisher = Just("Hello World")
        let subscription = publisher.sink { print($0) }
        subscription.cancel()
    }
}
