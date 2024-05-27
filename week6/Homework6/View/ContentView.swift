//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentTab = 0
    @State private var query = ""
    @StateObject var taskStore = TaskStore()
    
    var body: some View {
        NavigationStack {
            SearchView(text: $query)
            TabbedView(currentTab: $currentTab, query: $query, taskStore: taskStore)
                .navigationTitle("My Tasks")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if currentTab == 0 {
                            NewTaskButtonView(taskStore: taskStore)
                        }
                    }
                }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
