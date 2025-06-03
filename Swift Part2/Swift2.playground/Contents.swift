import Foundation

//MARK: --- Task1: User Registration and Login System
struct User {
    let username: String
    let email: String
    private var password: String

    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = User.hashPassword(password)
    }

    //hash simulation
    static func hashPassword(_ password: String) -> String {
        return String(password.reversed())
    }

    func verifyPassword(_ inputPassword: String) -> Bool {
        return User.hashPassword(inputPassword) == password
    }
}


class UserManager {
    var users: [String: User] = [:]

    func registerUser(username: String, email: String, password: String) -> Bool {
        if users[username] != nil {
            print("Username already exists")
            return false
        }
        let newUser = User(username: username, email: email, password: password)
        users[username] = newUser
        print("User '\(username)' registered successfully")
        return true
    }

    func login(username: String, password: String) -> Bool {
        guard let user = users[username] else {
            print("User not found")
            return false
        }
        if user.verifyPassword(password) {
            print("Login successful for user: \(username)")
            return true
        } else {
            print("Incorrect password")
            return false
        }
    }

    func removeUser(username: String) -> Bool {
        if users.removeValue(forKey: username) != nil {
            print("User '\(username)' removed")
            return true
        } else {
            print("User '\(username)' not found")
            return false
        }
    }

    var userCount: Int {
        return users.count
    }
}


class AdminUser: UserManager {
    var adminName: String

    init(adminName: String) {
        self.adminName = adminName
        print("Admin '\(adminName)' initialized")
    }

    func listAllUsers() -> [String] {
        return Array(users.keys)
    }

    deinit {
        print("Admin '\(adminName)' has been deallocated")
    }
}


var admin: AdminUser? = AdminUser(adminName: "SuperAdmin")

admin?.registerUser(username: "Ana Namgaladze", email: "Ana@gmail.com", password: "ana123")
admin?.registerUser(username: "John Doe", email: "johndoe@gmail.com", password: "john123")

admin?.login(username: "Ana Namgaladze", password: "ana123")
admin?.login(username: "John Doe", password: "wrongPassword")

print("Total users:", admin?.userCount ?? 0)

if let users = admin?.listAllUsers() {
    print("Registered users:", users)
}

admin?.removeUser(username: "Ana Namgaladze")

admin = nil

print("\nTask2:")
//MARK: --- Task 2: University Student Management System

class Person {
    let name: String
    var age: Int
    
    // Designated init
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    //failable init
    init?(name: String, inputAge: Int) {
        guard inputAge >= 16 else {
            return nil
        }
        self.name = name
        self.age = inputAge
    }
}


class Student: Person {
    let studentID: String
    var major: String
    
    // Required init
    required init(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
    }
    
    // Convenience init
    convenience init(studentID: String) {
        self.init(name: "Unknown", age: 19, studentID: studentID, major: "Undeclared")
    }
}

class Professor: Person {
    var faculty: String
    
    // Custom init calling superclass
    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)
    }
}

struct University {
    let name: String
    let location: String
}

if let person1 = Person(name: "Lika", inputAge: 15) {
    print("Person created: \(person1.name)")
} else {
    print("Person is too young")
}

let student1 = Student(name: "Ana", age: 20, studentID: "A0001", major: "Computer Science")
let student2 = Student(studentID: "S9999")
print("Name: \(student2.name)")
print("Age: \(student2.age)")
print("Student ID: \(student2.studentID)")
print("Major: \(student2.major)")

let professor = Professor(name: "Dr. Doe", age: 50, faculty: "Engineering")

let university = University(name: "BTU", location: "Tbilisi")

print("Student: \(student1.name), Major: \(student1.major)")
print("Professor: \(professor.name), Faculty: \(professor.faculty)")
print("University: \(university.name) in \(university.location)")


