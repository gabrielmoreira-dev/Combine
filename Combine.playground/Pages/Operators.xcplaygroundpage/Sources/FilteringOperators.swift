import Combine
import Foundation

public final class FilteringOperators {
    public static func executeFilter() {
        let publisher = [1, 2, 3, 4].publisher
        let filteredPublisher = publisher.filter { $0 % 2 == 0 }
        let _ = filteredPublisher.sink { print($0) }
    }

    public static func executeCompactMap() {
        let publisher = ["1", "2", "3", "4", "A"].publisher
        let compactMappedPublisher = publisher.compactMap { Int($0) }
        let _ = compactMappedPublisher.sink { print($0) }
    }

    public static func executeDebounce() {
        let publisher = PassthroughSubject<String, Never>()
        let debouncePublisher = publisher.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
        let _ = debouncePublisher.sink { print($0) }
        publisher.send("A")
        publisher.send("B")
        publisher.send("C")
    }
}
