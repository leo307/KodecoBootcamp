//
//  TaskStore.swift
//

import Foundation

struct Task: Identifiable, Hashable {
  let id = UUID()
  var title: String
  var category: Category
  var isCompleted: Bool = false
  var notes: String = ""
}

enum Category:String, CaseIterable {
  case personal = "Personal"
  case work = "Work"
  case home = "Home"
  case noCategory = "No Category"
}

class TaskStore: ObservableObject {
  @Published var tasks: [Task] = []
  @Published var addingTask = false

  init(_ loadData: Bool = true) {
    tasks.append(Task(title: "Buy groceries", category: .home))
    tasks.append(Task(title: "Walk the dog", category: .home))
    tasks.append(Task(title: "Water the plants", category: .home, isCompleted: true))
    tasks.append(Task(title: "Read a chapter of a book", category: .personal))
    tasks.append(Task(title: "Schedule an appointment with client", category: .work))
    tasks.append(Task(title: "Answer emails", category: .work))
    tasks.append(Task(title: "Workout for 30 minutes", category: .personal))
    tasks.append(Task(title: "Wash the car", category: .home, isCompleted: true))
    tasks.append(Task(title: "Clean the living room", category: .home))
    tasks.append(Task(title: "Prepare agenda for the week", category: .work))
    tasks.append(Task(title: "Call mom", category: .personal, isCompleted: true))
    tasks.append(Task(title: "Charge electronic devices", category: .personal))
    tasks.append(Task(title: "Update the software", category: .work))
    tasks.append(Task(title: "Buy a birthday gift", category: .personal))
    tasks.append(Task(title: "Study for the certification", category: .work))
    tasks.append(Task(title: "Fix the leaky faucet", category: .home))
    tasks.append(Task(title: "Organize architecture notes", category: .work))
    tasks.append(Task(title: "Take out the trash", category: .home))
    tasks.append(Task(title: "Visit grandma", category: .personal))
    tasks.append(Task(title: "Do laundry", category: .home, isCompleted: true))
    tasks.append(Task(title: "Bake cookies", category: .home))
    tasks.append(Task(title: "Pay monthly bills", category: .home))
    tasks.append(Task(title: "Plan the weekend trip",category: .personal, isCompleted: true))
    tasks.append(Task(title: "Attend the webinar", category: .work))
    tasks.append(Task(title: "Write technical specifications", category: .work))
    tasks.append(Task(title: "Mow the lawn", category: .home))
    tasks.append(Task(title: "Change light bulbs", category: .home))
    tasks.append(Task(title: "Return library books", category: .personal, isCompleted: true))
    tasks.append(Task(title: "Set up the planning meeting", category: .work))
    tasks.append(Task(title: "Paint bedroom", category: .home))
    tasks.append(Task(title: "Finish the project proposal", category: .work, isCompleted: true))
    tasks.append(Task(title: "Book a restaurant for anniversary", category: .personal))
    tasks.append(Task(title: "Recharge metro card", category: .personal))
    tasks.append(Task(title: "Watch the latest training video", category: .work))
    tasks.append(Task(title: "Test the new software", category: .work))
    tasks.append(Task(title: "Renew Apple Developer program", category: .work))
    tasks.append(Task(title: "Volunteer at the local shelter", category: .personal))
    tasks.append(Task(title: "Sign up for the yoga class", category: .personal))
    tasks.append(Task(title: "Listen to the new podcast episode", category: .personal, isCompleted: true))
    tasks.append(Task(title: "Mail the contracts", category: .work))
    tasks.append(Task(title: "Finish knitting the scarf", category: .home))
    tasks.append(Task(title: "Reorder printer ink", category: .work))
    tasks.append(Task(title: "Backup computer files", category: .work))
    tasks.append(Task(title: "Assemble the new furniture", category: .home))
    tasks.append(Task(title: "Donate old iPhones", category: .work))
    tasks.append(Task(title: "Schedule a haircut", category: .personal, isCompleted: true))
    tasks.append(Task(title: "Review the business proposal", category: .work))
    tasks.append(Task(title: "Edit the vacation photos", category: .personal))
    tasks.append(Task(title: "Plant new flowers in the garden", category: .home))
    tasks.append(Task(title: "Brush up on a foreign language", category: .personal, isCompleted: true))
  }

  func addTask(title: String) {
    print("enum: \(Category.personal)")
    tasks.append(Task(title: title, category: .noCategory))
  }

  func toggleTaskCompletion(task: Task) {
    if let index = tasks.firstIndex(where: { $0.id == task.id }) {
      tasks[index].isCompleted.toggle()
    }
  }
                 }
