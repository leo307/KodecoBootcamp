//
//  TaskRowView.swift
//  week5
//
//  Created by Leo DelPrete on 5/18/24.
//

import SwiftUI

struct TaskRowView: View {
    @Binding var task: Task
    @StateObject var taskStore = TaskStore()
    
    var body: some View {
        
            HStack{
                VStack {
                    NavigationLink(destination: TaskView(task: $task, taskStore: taskStore)){
                            Text(task.title)
                                .font(.title)
                                .padding(.horizontal)
                        }
                }
                Spacer()
                
                if(task.isCompleted == true){
                    Image(systemName: "checkmark.square.fill")
                        .foregroundColor(.green)
                        .padding(.horizontal)
                } else {
                    Image(systemName: "xmark.square.fill")
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
            }
        
        Divider()
            .padding()
        
        
    }
}

#Preview {
    TaskRowView(task: .constant(Task(id: UUID(), title: "heuf", notes: "Wash the dishes", isCompleted: false)))
}
