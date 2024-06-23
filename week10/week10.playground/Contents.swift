// Leo Delprete week10.playground 6-23-24

import Foundation

struct Fact: Codable {
    let fact: String
    let length: Int
}

struct Sequence: AsyncSequence {
    typealias Element = Fact
    
    struct Iterator: AsyncIteratorProtocol {
        var count: Int
        let maxCount: Int
        init(maxCount: Int) {
            self.count = 0
            self.maxCount = maxCount
        }
        
        mutating func next() async throws -> Fact? {
            let decoder = JSONDecoder()
            guard count < maxCount else {
                return nil
            }
            
            count += 1
            
            let url = URL(string: "https://catfact.ninja/fact")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let catFact = try decoder.decode(Fact.self, from: data)
            return catFact
        }
    }
    
    let maxCount: Int
    
    func makeAsyncIterator() -> Iterator {
        return Iterator(maxCount: maxCount)
    }
}

func fetchCatFacts(_ count: Int) async {
    let sequence = Sequence(maxCount: count)
    
    do {
        var iterator = sequence.makeAsyncIterator()
        while let catFact = try await iterator.next() {
            print("Cat Fact: \(catFact.fact)")
        }
    } catch {
        print("Error fetching cat facts: \(error)")
    }
}

Task {
    await fetchCatFacts(10) /* Wasn't sure if a do,try,catch, was necessary, so I wrote the call to the function in one line */
}
