//
//  TaskRow.swift
//

import SwiftUI

struct TaskRowView: View {
    
    var task: Task
    var taskStore: TaskStore
    @State private var checked = false
    
    
    var body: some View {
        HStack {
            Text(task.title)
            Spacer()
            Button(action: {
                withAnimation{
                    checked.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        
                        print(task.isCompleted)
                        taskStore.toggleTaskCompletion(task: task)

                    }
                }
            }){
                Image(systemName: task.isCompleted || checked ? "checkmark.square" : "square")
                    .foregroundColor(task.isCompleted || checked ? Color.green : Color.red)
            }
        }
        .buttonStyle(BorderlessButtonStyle())
        .font(.title3)
        .bold()
        .padding([.top, .bottom], 15)
        .padding([.leading, .trailing], 10)
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowView(task: Task(title: "My Task", category: .noCategory, isCompleted: false), taskStore: TaskStore())
    }
}
