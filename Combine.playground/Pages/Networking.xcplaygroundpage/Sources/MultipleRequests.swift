import Combine
import Foundation

struct MovieResponse: Decodable {
    let search: [Movie]

    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct Movie: Decodable {
    let title: String

    private enum CodingKeys: String, CodingKey {
        case title = "Title"
    }
}

public final class MovieService {
    public init() {}

    func fetchMovies(_ searchTerm: String) -> AnyPublisher<MovieResponse, Error> {
        let apiKey = "<YOUR KEY>"
        guard let url = URL(string: "https://www.omdbapi.com/?s=\(searchTerm)&page=2&apiKey=\(apiKey)") else {
            fatalError()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

public final class MovieRepository {
    private let movieService: MovieService
    private var subscriptions: Set<AnyCancellable> = []

    public init(movieService: MovieService = MovieService()) {
        self.movieService = movieService
    }

    public func fetchMovies() {
        Publishers.CombineLatest(
            movieService.fetchMovies("Batman"),
            movieService.fetchMovies("Spiderman")
        ).sink { _ in
        } receiveValue: {
            print($0.search)
            print($1.search)
        }.store(in: &subscriptions)
    }
}
