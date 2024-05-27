//
//  TaskRow.swift
//

import SwiftUI

struct TaskRowView: View {
    
    @Binding var task: Task
    var taskStore: TaskStore
    @State private var checked: Bool
    
    init(task: Binding<Task>, taskStore: TaskStore) {
        self._task = task
        self.taskStore = taskStore
        _checked = State(initialValue: task.wrappedValue.isCompleted)
    } // Not sure if this is the right method, but assigning and initializing checked, to isCompleted, works for the requirements.
    
    var body: some View {
        HStack {
            Text(task.title)
            Spacer()
            Button(action: {
                withAnimation {
                    checked.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        taskStore.toggleTaskCompletion(task: task)
                        // print(task.isCompleted) // debug
                    }
                }
            }) {
                Image(systemName: checked ? "checkmark.square" : "square")
                    .foregroundColor(checked ? Color.green : Color.red)
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
    
    @State static var task = Task(title: "Fix incompleting task animation", category: .noCategory, isCompleted: false)
    
    static var previews: some View {
        TaskRowView(task: $task, taskStore: TaskStore())
    }
}
