//
//  TaskListView.swift
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskStore: TaskStore
    @Binding var query: String
    @Binding var task: Task
    
    var body: some View {
        List {
            ForEach(Array(taskStore.tasks.enumerated().filter { !$0.element.isCompleted && (query.isEmpty || $0.element.title.lowercased().contains(query.lowercased())) }), id: \.element.id) { index, task in
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

struct TaskListView_Previews: PreviewProvider {
    
    @State static var query = ""
    @State static var task = Task(title: "Clean up the animation for completing tasks", category: .noCategory)
    
    static var previews: some View {
        TaskListView(taskStore: TaskStore(), query: $query, task: $task)
    }
}
