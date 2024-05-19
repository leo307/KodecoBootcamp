//
//  NewTaskView.swift
//  week5
//
//  Created by Leo DelPrete on 5/18/24.
//

import SwiftUI

struct NewTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var isCompleted: Bool = false
    
    @ObservedObject var taskStore: TaskStore
    
    var body: some View {
        VStack{
            HStack{
                Button("Cancel"){
                    dismiss()
                }
                .padding()
                
                Spacer()
                
                Text("New Task")
                
                Spacer()
                
                Button("Add"){
                    taskStore.addTask(task: Task(id: UUID(), title: title, notes: notes, isCompleted: isCompleted), tasks: &taskStore.tasks)
                    //                    print(taskStore.tasks.count) Debugging
                    dismiss()
                }
                .disabled(title.isEmpty)
                .padding()
                
            }
            
            TextField("Task Name", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Notes", text: $notes)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(minHeight: 100)
                .padding()
            Toggle("Completed", isOn: $isCompleted)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    NewTaskView(taskStore: TaskStore())
}
