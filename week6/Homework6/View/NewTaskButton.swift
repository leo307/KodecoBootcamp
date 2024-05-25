//
//  NewTaskButton.swift
//  
//
//import SwiftUI
//
//struct NewTaskButton: View {
//  @Binding var addingTask: Bool
//
//  var body: some View {
//    HStack {
//      Button(action: {
//        addingTask = true
//      }, label: {
//        HStack() {
//          Image(systemName: "plus.circle.fill")
//          Text("New Task")
//          Spacer()
//        }
//        .font(.title3)
//        .bold()
//        .padding(.leading, 20)
//      })
//    }
//  }
//}
//
//struct NewTaskButton_Previews: PreviewProvider {
//  static var previews: some View {
//    NewTaskButton(addingTask: .constant(true))
//  }
//}
