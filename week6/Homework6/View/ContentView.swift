//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
  @StateObject var taskStore = TaskStore()
  
  var body: some View {
    NavigationStack {
      VStack {
        if taskStore.tasks.isEmpty {
          Text("No tasks found")
        } else {
          TaskListView(taskStore: taskStore)
        }
        Spacer()
        //NewTaskButton(addingTask: $addingTask)
      }
      .navigationTitle("My Tasks")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          NewTaskButtonView(taskStore: taskStore)
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
