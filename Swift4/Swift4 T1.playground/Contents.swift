import UIKit

struct Stack<T> {
    private var items: [T] = []

    mutating func push(_ item: T) {
        items.append(item)
    }

    mutating func pop() -> T? {
        return items.popLast()
    }

    func size() -> Int {
        return items.count
    }

    func printStackContents() -> String {
        return items.map { "\($0)" }.joined(separator: ", ")
    }
}

var stack = Stack<Int>()
stack.push(5)
stack.push(10)
stack.push(11)

print("Popped:", stack.pop() ?? -1)
print("Size:", stack.size())
print("Stack:", stack.printStackContents())
