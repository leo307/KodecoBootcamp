//
//  TaskListView.swift
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskStore: TaskStore
    @Binding var query: String
    
    var body: some View {
        
        List(taskStore.tasks.filter { !$0.isCompleted && (query.isEmpty || $0.title.lowercased().contains(query.lowercased())) },id:\.id) { task in
            NavigationLink(destination: TaskDetailView(task: $taskStore.tasks.first(where: { $0.id == task.id })!)) {
                VStack {
                    TaskRowView(task: task, taskStore: taskStore)
                }
                .padding([.leading, .trailing], 20)
            }
        }
        .navigationTitle("Tasks")
    }
}

struct TaskListView_Previews: PreviewProvider {
    
    @State static var query = ""
    
    static var previews: some View {
        TaskListView(taskStore: TaskStore(), query: $query)
    }
}
