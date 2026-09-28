import Foundation

struct Student {
    let id: Int
    var name: String
    var age: Int
    var email: String?
    var scores: [Int] = []
    
    var average: Double? {
        guard !scores.isEmpty else { return nil }
        let sum = scores.reduce(0, +)
        return Double(sum) / Double(scores.count)
    }
    
    var grade: String {
        guard let avg = average else { return "-" }
        switch avg {
        case 90...100: return "A"
        case 80..<90: return "B"
        case 70..<80: return "C"
        case 50..<70: return "D"
        default: return "F"
        }
    }
}

var students: [Int: Student] = [:]
var isRunning = true

while isRunning {
    print("\n===== ACADEMIC MANAGER =====")
    print("1. Add student")
    print("2. View all students")
    print("0. Exit")
    print("Choose an option: ", terminator: "")
    
    guard let input = readLine(), let choice = Int(input) else {
        print("Invalid option.")
        continue
    }
    
    switch choice {
    case 1:
        print("Student ID: ", terminator: "")
        guard let idInput = readLine(), let id = Int(idInput), id > 0 else {
            print("Error: Invalid ID.")
            break
        }
        if students[id] != nil {
            print("Error: ID \(id) already exists.")
            break
        }
        
        print("Name: ", terminator: "")
        let name = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else {
            print("Error: Name cannot be empty.")
            break
        }
        
        print("Age: ", terminator: "")
        guard let ageInput = readLine(), let age = Int(ageInput), (16...60).contains(age) else {
            print("Error: Age must be between 16 and 60.")
            break
        }
        
        print("Email (optional): ", terminator: "")
        let emailInput = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailInput.isEmpty ? nil : emailInput
        if let email = email, !email.contains("@") {
            print("Error: Email must contain @.")
            break
        }
        
        students[id] = Student(id: id, name: name, age: age, email: email)
        print("Student added.")
        
    case 2:
        if students.isEmpty {
            print("No students yet.")
        } else {
            print(String(format: "%-6s %-10s %-8s %s", "ID", "Name", "Average", "Grade"))
            for student in students.values.sorted(by: { $0.id < $1.id }) {
                let avgStr = student.average.map { String(format: "%.2f", $0) } ?? "-"
                print(String(format: "%-6d %-10s %-8s %s", student.id, student.name, avgStr, student.grade))
            }
        }
        
    case 0:
        print("Goodbye!")
        isRunning = false
        
    default:
        print("Invalid option.")
    }
}