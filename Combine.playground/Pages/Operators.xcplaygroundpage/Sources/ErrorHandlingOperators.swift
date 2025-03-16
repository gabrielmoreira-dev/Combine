import Combine

enum PublisherError: Error {
    case operationFailed
}

public final class ErrorHandlingOperators {
    public static func executeCatch() {
        let publisher = [1, 2, 3, 4, 5].publisher
        let mappedPublisher = publisher
            .tryMap {
                if $0 == 4 {
                    throw PublisherError.operationFailed
                }
                return $0
            }
            .catch {
                print($0)
                return Just(-1)
            }
        let _ = mappedPublisher.sink { print($0) }
    }

    public static func executeReplaceError() {
        let publisher = [1, 2, 3, 4, 5].publisher
        let mappedPublisher = publisher
            .tryMap {
                if $0 == 4 {
                    throw PublisherError.operationFailed
                }
                return $0
            }
            .replaceError(with: -1)
        let _ = mappedPublisher.sink { print($0) }
    }

    public static func executeRetry() {
        let publisher = PassthroughSubject<Int, Error>()
        let mappedPublisher = publisher
            .tryMap {
                if $0 == 4 {
                    throw PublisherError.operationFailed
                }
                return $0
            }
            .retry(2)
        let subscription = mappedPublisher.sink {
            switch $0 {
            case .finished:
                print("Published has completed")
            case .failure(let error):
                print("Publisher failed with error \(error)")
            }
        } receiveValue: { print($0) }

        publisher.send(1)
        publisher.send(4)
        publisher.send(2)
        publisher.send(3)
        publisher.send(4)
        publisher.send(5)
        publisher.send(4)
        publisher.send(8)
    }
}
