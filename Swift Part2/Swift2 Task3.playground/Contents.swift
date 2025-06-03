import UIKit

class Person {
    let name: String
    var age: Int
    static let minAgeForEnrollment = 16
    
    var isAdult: Bool {
        return age >= 18
    }
    
    lazy var profileDescription: String = {
        return "\(name) is \(age) years old."
    }()
    
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
    weak var advisor: Professor?
    static let studentCount = StudentCountActor()
    
    var formattedID: String {
        return "ID: \(studentID.uppercased())"
    }
    
    required init(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
        Task { await Student.studentCount.increment() }
    }
    
    convenience init(studentID: String) {
        self.init(name: "Unknown", age: 19, studentID: studentID, major: "Undeclared")
    }
    
    deinit {
        Task { await Student.studentCount.decrement() }
    }
    
    static func getStudentCount() async -> Int {
        return await studentCount.getCount()
    }
}


actor StudentCountActor {
    private var count = 0
    
    func increment() {
        count += 1
    }
    
    func decrement() {
        count -= 1
    }
    
    func getCount() -> Int {
        return count
    }
}


class Professor: Person {
    var faculty: String
    static let professorCount = ProfessorCountActor()
    
    var fullTitle: String {
        return "Professor \(name), Faculty of \(faculty)"
    }
    
    // Custom init calling superclass
    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)
        Task { await Professor.professorCount.increment() }
    }
    
    deinit {
        Task { await Professor.professorCount.decrement() }
    }
    
    static func getProfessorCount() async -> Int {
        return await professorCount.getCount()
    }
}

actor ProfessorCountActor {
    private var count = 0
    
    func increment() {
        count += 1
    }
    
    func decrement() {
        count -= 1
    }
    
    func getCount() -> Int {
        return count
    }
    
}

struct University {
    let name: String
    let location: String
    var description: String {
        return "\(name) is located in \(location)."
    }
    
}

let student1 = Student(name: "Ana", age: 19, studentID: "a0001", major: "Computer Science")
let student2 = Student(studentID: "S9999")

let professor1 = Professor(name: "Nika", age: 45, faculty: "Engineering")
let professor2 = Professor(name: "Giorgi", age: 51, faculty: "Mathematics")
let university = University(name: "BTU",location: "Tbilisi")

print("Ana is adult: \(student1.isAdult)")
print("Minimum age for enrollment: \(Person.minAgeForEnrollment)")
print(student1.profileDescription)
print("Formatted ID: \(student1.formattedID)")
student1.advisor = professor1
print("Student advisor name: \(student1.advisor?.name ?? "None")")
print(professor1.fullTitle)
print(university.description)


Task {
    let studentCount = await Student.getStudentCount()
    let professorCount = await Professor.getProfessorCount()
    
    print("Student count: \(studentCount)")
    print("Professor count: \(professorCount)")
    
    print(professor1.fullTitle)
    print(professor2.fullTitle)
}
