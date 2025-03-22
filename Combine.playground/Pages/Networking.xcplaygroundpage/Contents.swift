print("\n\n----------- Single Request ------------")

let postRepository = PostRepository()
postRepository.fetchPosts()

print("\n\n---------- Multiple Requests -----------")

let movieRepository = MovieRepository()
movieRepository.fetchMovies()
