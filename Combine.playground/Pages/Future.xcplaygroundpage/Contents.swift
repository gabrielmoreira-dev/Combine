print("\n\n----------- Future Example ------------")

let subscription = FutureExample.execute()
subscription.sink { print($0) }

print("\n\n---------- Future Networking -----------")

Task {
    let postRepository = PostRepository()
    await postRepository.fetchPosts()
}
