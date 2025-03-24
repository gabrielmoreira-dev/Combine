print("\n\n----------- Future Example ------------")

let subscription = FutureExample.execute()
subscription.sink { print($0) }
