import Combine
import Foundation

struct Post: Decodable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

enum NetworkError: Error {
    case malformedURL
    case badRequest
    case badResponse
}

public final class APIClient {
    private typealias Promise<T> = Future<T, Error>.Promise
    private typealias Result = Subscribers.Completion<any Error>
    private let session: URLSession
    private var subscriptions: Set<AnyCancellable> = []

    public init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(_ urlString: String) -> Future<T, Error> {
        Future { [weak self] promise in
            guard let self else { return }
            guard let url = URL(string: urlString) else {
                promise(.failure(NetworkError.malformedURL))
                return
            }
            session.dataTaskPublisher(for: url)
                .tryMap(self.handleData)
                .retry(3)
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink {
                    self.handleResult($0, promise: promise)
                } receiveValue: {
                    self.handleSuccess($0, promise: promise)
                }
                .store(in: &self.subscriptions)
        }
    }

    private func handleData(data: Data, response: URLResponse) throws -> Data {
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

    private func handleResult<T>(_ result: Result, promise: Promise<T>) {
        switch result {
        case .finished:
            break
        case .failure(let error):
            promise(.failure(error))
        }
    }

    private func handleSuccess<T>(_ value: T, promise: Promise<T>) {
        promise(.success(value))
    }
}

public final class PostService {
    private let apiClient: APIClient

    public init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchPosts() -> Future<[Post], Error> {
        apiClient.fetch("https://jsonplaceholder.typicode.com/posts")
    }
}

public final class PostRepository {
    private let postService: PostService

    public init(postService: PostService = PostService()) {
        self.postService = postService
    }

    public func fetchPosts() async {
        do {
            let posts = try await postService.fetchPosts().value
            print(posts)
        } catch {
            print(error)
        }
    }
}

