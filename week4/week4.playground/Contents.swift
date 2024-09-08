// Question A
var numsArray = Array(0...20)
func average(of numbers: [Int]) -> Double? {
  guard !numbers.isEmpty else { return nil }

  let total = numbers.reduce(0, +)
  return Double(total) / Double(numbers.count)
}

func average(of numbers: Int...) -> Double? {
    return average(of: numbers)
}

let overloaded = average(of: numsArray)
print(overloaded as Any)


// Question B
enum Animal {
    case cow, snake, horse, seal, bird
}

func theSoundMadeBy(_ Animal: Animal) -> String {
        switch Animal {
        case .cow:
            return "A cow goes moooo."
        case .snake:
            return "A snake goes hiss."
        case .horse:
            return "A horse goes neigh."
        case .seal:
            return "A seal goes honk."
        case .bird:
            return "A bird goes squawk."
        }
    }

let bird = theSoundMadeBy(Animal.bird)
print(bird)


// Question C
let nums = Array(0...100)
let numsWithNil: [Int?] = [79, nil, 80, nil, 90, nil, 100, 72]
let numsBy2 = Array(stride(from: 2, through: 100, by: 2))
let numsBy4 = Array(stride(from: 4, through: 100, by: 4))

func evenNumbersArray(_ numbers: [Int]) -> [Int] {
    return numbers.filter { $0 % 2 == 0 }
}

func sumOfArray(_ numbers: [Int?]) -> Int {
    let sum = numbers.compactMap { $0 }.reduce(0, +)
    return sum
}

func commonElementsSet(_ array1: [Int], _ array2: [Int]) -> Set<Int> {
    let set1 = Set(array1)
    let set2 = Set(array2)
    return set1.intersection(set2)
}

let commonElements = commonElementsSet(numsBy2, numsBy4)
print(commonElements)

let arrayWithNil = sumOfArray(numsWithNil)
print(arrayWithNil)

let evens = evenNumbersArray(nums)
print(evens)


// Question D
struct Square {
    var sideLength: Double
    var area: Double {
        return sideLength * sideLength
    }
}

let square = Square(sideLength: 2.0)
print(square.area)


// No compiler errors as of 5/12/24
