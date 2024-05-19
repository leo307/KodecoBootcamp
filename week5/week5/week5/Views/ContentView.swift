//
//  ContentView.swift
//  week5
//
//  Created by Leo DelPrete on 5/18/24.
//

import SwiftUI

struct ContentView: View {
    @State private var sheetPresentedStatus = false
    @ObservedObject var taskStore = TaskStore()
    
    var body: some View {
        
        Text("My Tasks")
            .fontWeight(.bold)
            .font(.largeTitle)
            .padding()
        
        NavigationStack{
            ScrollView{
                VStack {
                    ForEach($taskStore.tasks, id: \.self){ $task in
                        TaskRowView(task: $task)
                    }
                    //                    Text(String(taskStore.tasks.count)) Debugging
                    Spacer()
                }
            }
            HStack{
                Image(systemName: "plus.circle")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Button(action:{
                    sheetPresentedStatus.toggle()
                    print(taskStore.tasks.count)
                }) {
                    Text("New Task")
                }.sheet(isPresented: $sheetPresentedStatus, content: {
                    NewTaskView(taskStore: taskStore)
                })
            }
        }
    }
    
}


#Preview {
    ContentView()
}
