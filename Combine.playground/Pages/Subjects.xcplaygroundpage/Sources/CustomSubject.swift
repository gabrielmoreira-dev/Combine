import Combine

public final class CustomSubject {
    public static func execute() {
        let subject = EvenSubject<Never>(initialValue: 1)
        let subscription = subject.sink { print($0) }
        subject.send(1)
        subject.send(2)
        subject.send(3)
        subject.send(4)
    }
}

final class EvenSubject<Failure: Error>: Subject {
    public typealias Output = Int

    private let wrapped: PassthroughSubject<Output, Failure>

    init(initialValue: Output) {
        self.wrapped = PassthroughSubject()
        send(initialValue)
    }

    public func send(subscription: any Subscription) {
        wrapped.send(subscription: subscription)
    }

    public func send(_ value: Int) {
        guard value % 2 == 0 else { return }
        wrapped.send(value)
    }

    public func send(completion: Subscribers.Completion<Failure>) {
        wrapped.send(completion: completion)
    }

    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Int == S.Input {
        wrapped.receive(subscriber: subscriber)
    }
}
