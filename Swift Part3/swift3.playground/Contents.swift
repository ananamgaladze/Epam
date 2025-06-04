import UIKit

//MARK: --- Task 1: Library Management System
protocol Borrowable: AnyObject {
    var borrowDate: Date? { get set }
    var returnDate: Date? { get set }
    var isBorrowed: Bool { get set }
    
    func checkIn()
}

extension Borrowable {
    func isOverdue() -> Bool {
        guard let returnDate = returnDate else { return false }
        return Date() > returnDate
    }
    
    func checkIn() {
        borrowDate = nil
        returnDate = nil
        isBorrowed = false
    }
}

class Item {
    let id: String
    let title: String
    let author: String
    
    init(id: String, title: String, author: String) {
        self.id = id
        self.title = title
        self.author = author
    }
}


class Book: Item, Borrowable {
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool
    
    init(id: String, title: String, author: String, isBorrowed: Bool = false) {
        self.isBorrowed = isBorrowed
        super.init(id: id, title: title, author: author)
    }
}

enum LibraryError: Error {
    case itemNotFound
    case itemNotBorrowable
    case alreadyBorrowed
}

class Library {
    private var items: [String: Item] = [:]
    
    func addBook(_ book: Book) {
        items[book.id] = book
    }
    
    func borrowItem(by id: String) throws -> Item {
        guard let item = items[id] else {
            throw LibraryError.itemNotFound
        }
        
        guard let borrowable = item as? Borrowable else {
            throw LibraryError.itemNotBorrowable
        }
        
        if borrowable.isBorrowed {
            throw LibraryError.alreadyBorrowed
        }
        
        borrowable.isBorrowed = true
        borrowable.borrowDate = Date()
        borrowable.returnDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())
        
        return item
    }
}

let library = Library()
let book1 = Book(id: "001", title: "1984", author: "George Orwell")
let book2 = Book(id: "002", title: "To Kill a Mockingbird", author: "Harper Lee")

library.addBook(book1)
library.addBook(book2)


do {
    let borrowed = try library.borrowItem(by: "001")
    print("Borrowed: \(borrowed.title)")

    if let borrowable = borrowed as? Borrowable {
        print("Return Date: \(borrowable.returnDate!)")
        print("Is Overdue? \(borrowable.isOverdue() ? "Yes" : "No")")
    }

    (borrowed as? Borrowable)?.checkIn()
    print("Checked in. isBorrowed: \((borrowed as? Borrowable)?.isBorrowed == true ? "Yes" : "No")")

} catch {
    print("Error: \(error)")
}

//MARK: --- Task 2: Type Casting and Nested Types in a School System
struct School {
    enum SchoolRole {
        case student
        case teacher
        case administrator
    }
    
    class Person {
        let name: String
        let role: SchoolRole
        init(name: String, role: SchoolRole) {
            self.name = name
            self.role = role
        }
    }
    
    private var personsArray = [Person]()
    
    subscript(role: SchoolRole) -> [Person] {
        return personsArray.filter { $0.role == role }
    }
    
    mutating func addPerson(_ person: Person) {
        personsArray.append(person)
    }
    
}

func countStudents(in school: School) -> Int {
    return school[.student].count
}

func countTeachers(in school: School) -> Int {
    return school[.teacher].count
}

func countAdministrators(in school: School) -> Int {
    return school[.administrator].count
}

var school = School()
school.addPerson(School.Person(name: "Ana", role: .student))
school.addPerson(School.Person(name: "Mari", role: .teacher))
school.addPerson(School.Person(name: "Davit", role: .student))
school.addPerson(School.Person(name: "Diana", role: .administrator))

let studentCount = countStudents(in: school)
let teacherCount = countTeachers(in: school)
let adminCount = countAdministrators(in: school)


//MARK: --- Task 3: Higher Order Functions
let books = [
    ["title": "Swift Fundamentals", "author": "John Doe", "year": 2015, "price": 40, "genre": ["Programming", "Education"]],
    ["title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925, "price": 15, "genre": ["Classic", "Drama"]],
    ["title": "Game of Thrones", "author": "George R. R. Martin", "year": 1996, "price": 30, "genre": ["Fantasy", "Epic"]],
    ["title": "Big Data, Big Dupe", "author": "Stephen Few", "year": 2018, "price": 25, "genre": ["Technology", "Non-Fiction"]],
    ["title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960, "price": 20, "genre": ["Classic", "Drama"]]
]

let discountedPrices: [Double] = books.compactMap { book in
    if let price = book["price"] as? Int {
        return Double(price) * 0.9
    }
    return nil
}
print("discountedPrices \(discountedPrices)")

let booksPostedAfter2000: [String] = books.filter { book in
    if let year = book["year"] as? Int {
        return year > 2000
    }
    return false
}
    .compactMap { $0["title"] as? String }

print("booksPostedAfter2000: \(booksPostedAfter2000)")


let allGenres: Set<String> = Set(
    books.flatMap { book in
        book["genre"] as? [String] ?? []
    }
)
print("Genres: \(allGenres)")


let totalCost: Int = books.reduce(0) { sum, book in
    sum + (book["price"] as? Int ?? 0)
}
print("totalCost: \(totalCost)")
