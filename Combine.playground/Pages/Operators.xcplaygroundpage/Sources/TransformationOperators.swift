import Combine

public final class TransformationOperators {
    public static func executeMap() {
        let publisher = (1...5).publisher
        let mappedPublisher = publisher.map { "Item #\($0)" }
        let _ = mappedPublisher.sink { print($0) }
    }

    public static func executeFlatMap() {
        let publisher = ["John", "Mary", "Steven"].publisher
        let flatMappedPublisher = publisher.flatMap { $0.publisher }
        let _ = flatMappedPublisher.sink { print($0) }
    }

    public static func executeMerge() {
        let publisher1 = [1, 2, 3].publisher
        let publisher2 = [4, 5, 6].publisher
        let mergedPublisher = Publishers.Merge(publisher1, publisher2)
        let _ = mergedPublisher.sink { print($0) }
    }
}
