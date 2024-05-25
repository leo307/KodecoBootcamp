//
//  TaskDetail.swift
//  

import SwiftUI

struct TaskDetailView: View {
  @Binding var task: Task
  var body: some View {
    VStack {
      Form {
        Section(header: Text("Task Title")) {
          TextField("Title", text: $task.title)
        }
        Section(header: Text("Notes")) {
          TextField("Notes", text: $task.notes, axis: .vertical)
            .lineLimit(5...)
        }
        Section {
          Toggle("Completed: ", isOn: $task.isCompleted)
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      Spacer()
    }
  }
}

struct TaskDetail_Previews: PreviewProvider {
  @State static var task = Task(title: "This Task", category: .noCategory)
  static var previews: some View {
    TaskDetailView(task: $task)
  }
}
