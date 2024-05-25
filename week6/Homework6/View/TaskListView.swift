//
//  TaskListView.swift
//  

import SwiftUI

struct TaskListView: View {
  @ObservedObject var taskStore: TaskStore
  var body: some View {
    VStack {
      ScrollView {
        ForEach(taskStore.tasks, id: \.self) { task in
          NavigationLink(value: task) {
            VStack {
              TaskRowView(task: task)
              Divider()
            }
            .padding([.leading, .trailing], 20)
          }
        }
        .navigationDestination(for: Task.self) { task in
          TaskDetailView(task: $taskStore.tasks
            .first(where: { $0.id == task.id })!)
        }
      }
    }
  }
}

struct TaskListView_Previews: PreviewProvider {
  static var previews: some View {
    TaskListView(taskStore: TaskStore())
  }
}
