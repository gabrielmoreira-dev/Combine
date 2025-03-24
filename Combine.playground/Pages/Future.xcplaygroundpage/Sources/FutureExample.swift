import Combine
import Foundation

public final class FutureExample {
    public static func execute() -> Future<Int, Never> {
        Future() { promise in
            promise(.success(Int.random(in: 1...10)))
        }
    }
}
