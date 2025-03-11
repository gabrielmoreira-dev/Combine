import Combine

public final class CombiningOperators {
    public static func executeCombineLatest() {
        let publisher1 = CurrentValueSubject<Int, Never>(1)
        let publisher2 = CurrentValueSubject<String, Never>("Hello World")
        let combinedPublisher = publisher1.combineLatest(publisher2)
        let subscription = combinedPublisher.sink { print("\($0), \($1)") }
        publisher1.send(3)
        publisher2.send("A")
    }

    public static func executeZip() {
        let publisher1 = [1, 2, 3].publisher
        let publisher2 = ["A", "B", "C"].publisher
        let zippedPublisher = publisher1.zip(publisher2)
        let _ = zippedPublisher.sink { print("\($0), \($1)") }
    }

    public static func executeSwitchToLatest() {
        let outerPublisher = PassthroughSubject<AnyPublisher<Int, Never>, Never>()
        let innerPublisher1 = CurrentValueSubject<Int, Never>(1)
        let innerPublisher2 = CurrentValueSubject<Int, Never>(2)
        let subscription = outerPublisher.switchToLatest().sink { print($0) }

        outerPublisher.send(AnyPublisher(innerPublisher1))
        innerPublisher1.send(10)

        outerPublisher.send(AnyPublisher(innerPublisher2))
        innerPublisher2.send(20)
    }
}
