import Combine

enum PublisherError: Error {
    case operationError
}

public final class SequencePublisherExample {
    public static func execute() {
        let publisher = [1, 2, 3, 4].publisher
        let publisher2 = publisher
            .tryMap {
                if $0 == 3 {
                    throw PublisherError.operationError
                }
                return $0 * 2
            }
            .catch {
                print("Error: \($0)")
                return Just(-1)
            }

        let _ = publisher2.sink { print($0) }
    }
}
