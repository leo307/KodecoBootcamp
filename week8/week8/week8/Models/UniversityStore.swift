//
//  UniversityStore.swift
//  week8
//
//  Created by Leo DelPrete on 6/9/24.
//

import Foundation

class UniversityStore: ObservableObject {
    
    @Published var universities: [University] = []

    @MainActor func fetchData() async {
        
        let decoder = JSONDecoder()
        guard let url = URL(string: "http://universities.hipolabs.com/search?country=United+States") else {
            print("Error URL incorrect")
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error bad response")
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                print("Error failed with code \(httpResponse.statusCode)")
                return
            }

            let universities = try decoder.decode([University].self, from: data)
            DispatchQueue.main.async {
                self.universities = universities
                print(universities) // debug
            }
        } catch {
            print("Error fetching data")
        }
    }
}
