//
//  TaskView.swift
//  week5
//
//  Created by Leo DelPrete on 5/18/24.
//

import SwiftUI

struct TaskView: View {
    
    @Binding var task: Task
    @ObservedObject var taskStore: TaskStore
    
    var body: some View {
        VStack {
            Text(task.title)
                .font(.largeTitle)
                .padding()
            Text(task.notes)
                .font(.title2)
                .padding()
            Toggle("Completed", isOn: $task.isCompleted)
                .onChange(of: task.isCompleted) {
                    taskStore.completeTask(task: &task)
                }
                .padding()
            
//            Button(action: {
//                taskStore.deleteTask(task: task)
//                print(taskStore.tasks.count)
//            }) {
//                Text("Delete Task")
//                Image(systemName: "trash.circle.fill")
//                    .foregroundColor(.red)
//                
//            } Not working as of 5/19/24
            Spacer()
        }
    }
}

#Preview {
    TaskView(task: .constant(Task(id: UUID(), title: "Test Test Test", notes: "Wash the dishes", isCompleted: false)), taskStore: TaskStore())
}
