import Combine

public final class Subjects {
    public static func executePassthroughSubject() {
        let subject = PassthroughSubject<Int, Never>()
        let subscription = subject.sink { print($0) }
        subject.send(1)
        subject.send(2)
    }

    public static func executeCurrentValueSubject() {
        let subject = CurrentValueSubject<Int, Never>(1)
        let subscription = subject.sink { print($0) }
        subject.send(2)
    }
}
