//
//  TaskStore.swift
//  week5
//
//  Created by Leo DelPrete on 5/18/24.
//

import SwiftUI

class TaskStore: ObservableObject {
    
    @Published var tasks: [Task] = [
        Task(id: UUID(), title: "Run the dishwasher", notes: "Run with warm water, and check dishes after", isCompleted: false),
        Task(id: UUID(), title: "Water the flowers", notes: "Water each flower for around 10 seconds", isCompleted:true),
        Task(id: UUID(), title: "Take the dogs out", notes: "Take outside when needed, let free outside if gate is unlocked", isCompleted: false),
        Task(id: UUID(), title: "Vacuum the floors", notes: "", isCompleted: false),
        Task(id: UUID(), title: "Make sure the doors are locked", notes: "Double check at night", isCompleted: true),
        Task(id: UUID(), title: "Bring bear spray if hiking", notes: "Should be on laundry room countertop, make sure to watch instructional video", isCompleted: false),
    ]

    
    func addTask(task: Task, tasks: inout [Task]){
        tasks.append(task)
    }
    
    func completeTask(task: inout Task) {
        task.isCompleted = true
    }
    
//    func deleteTask(task: Task) {
//        
//    } Not working as of 5/19/24
}
