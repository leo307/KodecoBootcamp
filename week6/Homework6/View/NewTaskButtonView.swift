//
//  NewTaskButtonView.swift
//

import SwiftUI

struct NewTaskButtonView: View {
  @ObservedObject var taskStore: TaskStore

  var body: some View {
    Button(action: {
      taskStore.addingTask.toggle()
    }, label: {
      Image(systemName: "plus.circle")
        .font(.title3)
        .bold()
    })
    .sheet(isPresented: $taskStore.addingTask) {
        AddTaskView(taskStore: taskStore)
    }
  }
}

struct NewTaskButton_Previews: PreviewProvider {
  static var previews: some View {
    NewTaskButtonView(taskStore: TaskStore())
  }
}
