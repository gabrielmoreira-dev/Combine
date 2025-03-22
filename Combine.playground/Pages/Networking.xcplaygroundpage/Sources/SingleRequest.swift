import Combine
import Foundation

struct Post: Decodable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

enum NetworkError: Error {
    case badRequest
    case badResponse
}

public final class PostService {
    public init() {}

    func fetchPosts() -> AnyPublisher<[Post], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(handleResult)
            .retry(3)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func handleResult(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        switch httpResponse.statusCode {
        case 400..<500:
            throw NetworkError.badRequest
        case 500..<600:
            throw NetworkError.badResponse
        default:
            break
        }
        return data
    }
}

public final class PostRepository {
    private let postService: PostService
    private var subscriptions: Set<AnyCancellable> = []

    public init(postService: PostService = PostService()) {
        self.postService = postService
    }

    public func fetchPosts() {
        postService.fetchPosts().sink {
            switch $0 {
            case .finished:
                print("Update UI")
            case .failure(let error):
                print(error)
            }
        } receiveValue: {
            print($0)
        }.store(in: &subscriptions)
    }
}
