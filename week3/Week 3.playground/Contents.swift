// Question A
var nums: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

for evenNum in nums {
    if evenNum % 2 == 0 {
        print(evenNum)
    }
}


// Question B
let sentence = "The qUIck bRown fOx jumpEd over the lAzy doG"
let newSentence = sentence.lowercased()
let vowels: [Character] = ["a", "e", "i", "o", "u"]
var count = 0

for vowel in newSentence {
    if(vowels.contains(vowel)){
        count += 1
    }
}
print("Number of vowels - \(count)")


// Question C
let vals1: [Int] = [0, 2, 3, 4]
let vals2: [Int] = [0, 2, 3, 4]

for val1 in vals1 {
    for val2 in vals2{
        let product = val1 * val2
        print("\(val1) * \(val2) = \(product)")
    }
}


// Question D
var optional: [Int]?
func average(numbs: [Int]?) {
    guard let numbs = numbs, !numbs.isEmpty else {
        print("The array is nil. Calculating the average is impossible.")
        return
    }
    let sum = numbs.reduce(0, +)
    let average = Double(sum) / Double(numbs.count)
    print("The average of the values in the array is \(average)")
}

average(numbs: nums)
average(numbs: optional)


// Question E
struct Person {
    let firstName: String
    let lastName: String
    var age: Int
    
    func details(){
        print("Name: \(firstName) \(lastName), Age: \(age)")
    }
}

let leo = Person(firstName: "Leo", lastName: "Delprete", age: 19)
leo.details()


// Question F
class Student {
    var person: Person
    var grades: [Int]
    
    init(person: Person, grades: [Int]){
        self.person = person
        self.grades = grades
    }
    
    func calculateAverageGrade() ->Double {
        let sum = grades.reduce(0, +)
        let average = Double(sum) / Double(grades.count)
        return average
    }
    
    func details() {
        print("Name: \(person.firstName) \(person.lastName), Age: \(person.age), GPA: \(calculateAverageGrade())")
    }
}
let receivedGrades = [94, 99, 81, 100, 79]
let student = Student(person: leo, grades: receivedGrades)
student.details()




// Above and Beyond
struct Square {
  var side: Int

  func area() -> Int {
    return side * side
  }
}

class Rectangle {
  var length: Int
  var width: Int

  init(length: Int, width: Int) {
    self.length = length
    self.width = width
  }

  func area() -> Int {
    return length * width
  }
}

var square1 = Square(side: 4)
var square2 = square1
square2.side = 5

print("Area: square1 - \(square1.area()) square2 - \(square2.area())")

var rectangle1 = Rectangle(length: 4, width: 4)
var rectangle2 = rectangle1
rectangle2.length = 5

print("Area: rectangle1 - \(rectangle1.area()) rectangle2 - \(rectangle2.area())")
