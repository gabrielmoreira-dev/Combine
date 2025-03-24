import Combine

extension Publisher where Output == Int {
    func filterEvenNumbers() -> AnyPublisher<Int, Failure> {
        self.filter { $0 % 2 == 0 }
            .eraseToAnyPublisher()
    }

    func filterNumberGreaterThan(_ value: Int) -> AnyPublisher<Int, Failure> {
        self.filter { $0 > value }
            .eraseToAnyPublisher()
    }
}

public final class CustomOperator {
    public static func execute() {
        let publisher = [1, 2, 3, 4, 5, 6, 7, 8].publisher
        let _ = publisher
            .filterEvenNumbers()
            .filterNumberGreaterThan(2)
            .sink { print($0) }
    }
}
