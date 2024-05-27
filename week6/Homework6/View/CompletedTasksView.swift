//
//  CompletedTasksView.swift
//  Homework6
//
//  Created by Leo DelPrete on 5/26/24.
//

import SwiftUI

struct CompletedTasksView: View {
    
    @ObservedObject var taskStore: TaskStore
    @Binding var query: String
    @Binding var task: Task
    
    
    var body: some View {
        List {
            ForEach(Array(taskStore.tasks.enumerated().filter { $0.element.isCompleted && (query.isEmpty || $0.element.title.lowercased().contains(query.lowercased())) }), id: \.element.id) { index, task in
                NavigationLink(destination: TaskDetailView(task: $taskStore.tasks[index])) {
                    VStack {
                        TaskRowView(task: $taskStore.tasks[index], taskStore: taskStore)
                    }
                    .padding([.leading, .trailing], 20)
                }
            }
        }
        .navigationTitle("Tasks")
    }
}

struct CompletedTasksView_Previews: PreviewProvider {
    
    @State static var query = ""
    @State static var task = Task(title: "Clean up the animation for completing tasks", category: .noCategory)
    
    
    static var previews: some View {
        CompletedTasksView(taskStore: TaskStore(), query: $query, task: $task)
    }
}
