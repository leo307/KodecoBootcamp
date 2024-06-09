//
//  ContentView.swift
//  week8
//
//  Created by Leo DelPrete on 6/9/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var fetchUniversities = UniversityStore()
    
    var body: some View {
        NavigationView {
            List(fetchUniversities.universities) { university in
                NavigationLink(destination: DetailView(university: university)) {
                    Text(university.name)
                }
            }
            .navigationTitle("Colleges")
            .task {
                await fetchUniversities.fetchData()
            }
        }
    }
}

#Preview {
    ContentView()
}
