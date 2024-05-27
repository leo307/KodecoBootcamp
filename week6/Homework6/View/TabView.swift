//
//  TabView.swift
//  Homework6
//
//  Created by Leo DelPrete on 5/26/24.
//

import SwiftUI

struct TabbedView: View {
    
    @Binding var currentTab: Int
    @Binding var query: String
    @ObservedObject var taskStore = TaskStore()
    @Binding var task: Task
    
    var body: some View {
        TabView(selection: $currentTab) {
            TaskListView(taskStore: taskStore, query: $query, task: $task)
                .tabItem {
                    Label("Tasks", systemImage: "list.bullet.circle")
                }
                .tag(0)
            
            CompletedTasksView(taskStore: taskStore, query: $query, task: $task)
                .tabItem {
                    Label("Completed", systemImage: "checkmark.circle")
                }
                .tag(1)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    // Temp variable for preview to work
    @State static var query = ""
    @State static var task = Task(title: "Clean up the animation for completing tasks", category: .noCategory)
    
    static var previews: some View {
        TabbedView(currentTab: .constant(0), query: $query, task: $task)
    }
}
