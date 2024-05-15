//
//  ToDoListVM.swift
//  ToDoList
//
//  Created by 노주영 on 2023/11/09.
//

import Foundation

class ToDoListViewModel {
    var toDoList: [ToDo] = [
        ToDo(title: "Grocery shopping", description: "Buy milk, eggs, bread, and cheese.", completed: false),
        ToDo(title: "iOS Project", description: "Work on the SwiftUI to-do list app.", completed: false),
        ToDo(title: "Read SwiftUI Documentation", description: "Read the latest SwiftUI tutorials on Apple's developer website.", completed: false),
        ToDo(title: "Fitness", description: "Go for a 30-minute run in the park.", completed: true),
        ToDo(title: "Book Club", description: "Finish reading 'The Midnight Library' for the book club meeting.", completed: false),
        ToDo(title: "Laundry", description: "Wash and fold clothes for the upcoming week.", completed: false),
        ToDo(title: "Weekly Planning", description: "Plan out the work schedule for the next week, set goals and priorities.", completed: false),
        ToDo(title: "Gardening", description: "Plant new flower seeds in the garden and water the plants.", completed: false),
        ToDo(title: "Learn Guitar", description: "Practice guitar chords for at least 20 minutes.", completed: true),
        ToDo(title: "Call Parents", description: "Have a catch-up call with mom and dad.", completed: true)
    ]
    
    func saveTodo(title: String, description: String) {
        self.toDoList.append(ToDo(title: title, description: description, completed: false))
    }
    
    func changeToDo(row: Int, title: String, description: String, completed: Bool) {
        toDoList[row] = ToDo(title: title, description: description, completed: completed)
    }
}
