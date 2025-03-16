import Combine
import Foundation

public final class SubjectExample {
    public static func execute() {
        let client = WeatherClient()
        let subscription = client.subscribe { print($0) }
        client.fetch()
    }
}

final class WeatherClient {
    private let subject = PassthroughSubject<Int, Never>()

    func subscribe(receiveValue: @escaping (Int) -> Void) -> AnyCancellable {
        subject.sink(receiveValue: receiveValue)
    }

    func fetch() {
        subject.send(Int.random(in: 25...40))
    }
}
