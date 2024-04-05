print("hello")

// this makes sense why you need to annotate so you know how much space to allocate for the variable
let myVar: Int

myVar = 70

let testFloat: Float = 4

let label = "The width is"
let width = 94
let widthLabel = label + " " + String(width)

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

let quotation = """
This is a long line of text
which I am not sure how it will end or be formatted.
    Oh!
"""

// if let, can't mutate the individual elements
var greetings = ["hey", "yo"]
greetings[0] = "sup"
print(greetings)

let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0

for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}


let scoreDecoration = if teamScore > 10 {
    "🎉"
} else {
    "👻"
}

var optionalName: String? = nil
var greeting = "Hey"
if let optionalName {
    greeting = "Hey \(optionalName)"
} else {
    greeting
}

let nickname: String? = nil
let fullName = "John Appleseed"
// has to be initialized to nil before being used
let informalGreeting = "Hi \(nickname ?? fullName)"

fullName.starts(with: "John")

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]

var largest: (name: String, value: Int)?
for (name, values) in interestingNumbers {
    for value in values {
        if let currLargest = largest {
            if currLargest.value < value {
                largest = (name, value)
            }
        } else {
            largest = (name, value)
        }
    }
}

var retStr = "There was no largest value"

if let largest {
    retStr = "The largest value (\(largest.1) came from category \(largest.0)."
}

print(retStr)

var total = 0
// this omits top value, ... includes it
for i in 0..<4 {
    total += i
}

// you can label tuples as well
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0


    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }


    return (min, max, sum)
}

calculateStatistics(scores: [5])

func makeIncrementer() -> (Int) -> Int {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}

var incrementer = makeIncrementer()
incrementer(8)

func actualIncrementer(number: Int) -> (Int) -> Int {
    func increment(incBy: Int) -> Int {
        return number + incBy
    }
    return increment
}

var newIncrementer = actualIncrementer(number: 10)
// we are not calling it by name, we are calling the function type directly, so don't have labels
newIncrementer(10)

var completion: (Bool) -> String = { success in
    return "Operation completed: \(success)."
}

completion(true)

func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    number < 10
}

var numbers = [1,2,3,60,10]
hasAnyMatches(list: numbers, condition: lessThanTen)

numbers.map({(number: Int) -> Int in
    let result = 3 * number
    return result
})

let times3 = numbers.map({$0 * 3})
print(times3)

let listWithZerosForOdds = numbers.map { $0 % 2 == 0 ? $0 : 0}
print(listWithZerosForOdds)

// Every property needs a value assigned - either in its declaration, or in the initializer
class NamedShape {
    var numberOfSides = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides)."
    }
}

var shape = NamedShape(name: "Square")
shape.name

// properties are instance properties by default, so each instance gets a copy
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        // ensures the inherited properties are initialized according to the superclass's initializer
        super.init(name: name)
        // numberOfSides = 4
        // can say numberOfSides, or super.numberOfSides; it is the same inherited property
        super.numberOfSides = 4
    }
    
    func area() -> Double {
        self.sideLength * self.sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

// still returns 0
shape.numberOfSides


let test = Square(sideLength: 5.2, name: "my test square")
// returns 4
test.numberOfSides

struct BasicStruct: Equatable {
    var number: Int
}

var basic1 = BasicStruct(number: 10)
var basic2 = BasicStruct(number: 10)
basic1 == basic2

// 3 steps in the initializer:
// Setting the value of properties that the subclass declares.
// Calling the superclass’s initializer.
// Changing the value of properties defined by the superclass. Any additional setup work that uses methods, getters, or setters can also be done at this point.
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            3.0 * sideLength
        }
        // can set it with parens here
        set (newV) {
            // new value has implicit name newValue
            sideLength = newV / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}

var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
triangle.perimeter
triangle.perimeter = 10
triangle.sideLength

class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name: String) {
        self.triangle = EquilateralTriangle(sideLength: size, name: name)
        self.square = Square(sideLength: size, name: name)
    }
}

let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength

enum Rank: Int, CaseIterable {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
        case .ace:
            "ace"
        case .jack:
            "jack"
        case .queen:
            "queen"
        case .king:
            "king"
        default:
            String(self.rawValue)
        }
    }
}

func compareRanks(rank1: Rank, rank2: Rank) -> String {
    let (smaller, larger) = rank1.rawValue > rank2.rawValue ? (rank1, rank2) : (rank1, rank2)
    return "\(larger.simpleDescription()) is larger than \(smaller.simpleDescription())"
}

let ace = Rank.ace
let four = Rank.four

compareRanks(rank1: ace, rank2: four)

if let convertedRank = Rank(rawValue: 1) {
    convertedRank.simpleDescription()
} else {
    print("no matching raw value")
}

// don't need to provide a raw value
enum Suit: CaseIterable {
    case spades, hearts, diamonds, clubs
    
    func simpleDescription() -> String {
        switch self {
        case .spades:
            "spades"
        case .hearts:
            "hearts"
        case .diamonds:
            "diamonds"
        case .clubs:
            "clubs"
        }
    }
    
    func color() -> String {
        switch self {
        case .spades, .clubs:
            "black"
        case .hearts, .diamonds:
            "red"
        }
    }
}
let spades = Suit.spades
spades.simpleDescription()
spades.color()

// can either have raw values as part of the enum declaration, or associate values with particular cases
enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("6:00am", "8:09pm")
let failure = ServerResponse.failure("We messed up")

switch failure {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure...  \(message)")
}

struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .three, suit: .spades)
threeOfSpades.simpleDescription()

func createDeck() -> [Card] {
    var cards: [Card] = []
    // enum needs to conform to CaseIterable to loop over its cases
    for suit in Suit.allCases {
        for rank in Rank.allCases {
            cards.append(Card(rank: rank, suit: suit))
        }
    }
    return cards
}

createDeck()

func fetchUserId(from server: String) async -> Int {
    if server == "primary" {
        return 97
    }
    return 501
}

func fetchUsername(from server: String) async -> String {
    let userId = await fetchUserId(from: server)
    if userId == 501 {
        return "Some dude"
    }
    return "Guest"
}

func connectUser(to server: String) async {
    async let userId = fetchUserId(from: server)
    async let username = fetchUsername(from: server)
    let greeting = await "Hello \(username), user ID \(userId)"
    print(greeting)
}

Task {
    await connectUser(to: "primary")
}

// does not wait for the return
func syncCallsAsync() {
    Task {
        await connectUser(to: "primary")
    }
}

// Int.self is a metatype (type of the type)
// x: Int refers to an instance of the type
// comes up in the case of generics
// specifyin the type of the return values of the tasks
let userIds = await withTaskGroup(of: Int.self) { group in
    for server in ["primary", "secondary", "dev"] {
        group.addTask {
            return await fetchUserId(from: server)
        }
    }
    
    var results: [Int] = []
    for await result in group {
        results.append(result)
    }
    return results
}

// actors serialize access to shared state
actor ServerConnection {
    var server: String = "primary"
    private var activeUsers: [Int] = []
    func connect() async -> Int {
        let userId = await fetchUserId(from: server)
        activeUsers.append(userId)
        return userId
    }
}

// Classes, Enums, and Structs can all adopt protocols (user-created types)

// extension Double:

protocol AbsVal {
    var absoluteValue: Double { get }
}

extension Double: AbsVal {
    var absoluteValue: Double {
        get {
            self < 0.0 ? -self : self
        }
    }
}

let x = -3.3
print(x.absoluteValue)

protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}
    
extension Int: ExampleProtocol {
    var simpleDescription: String {
        "The number is \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}

// can use protocols like any other named type - eg, to create a collection of objects that have different types but that all conform to a single protocol
let protocolValue: any ExampleProtocol = 5

// conforms to Error, so we can "Throw" it
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}

do {
    let printerResp = try send(job: 1020, toPrinter: "Bi Sheng")
    print(printerResp)
} catch {
    print(error)
}

do {
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    throw PrinterError.onFire
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}

enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}

var possibleInt: OptionalValue<Int> = .none
possibleInt = .some(100)

