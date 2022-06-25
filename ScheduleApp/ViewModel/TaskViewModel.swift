//
//  TaskViewModel.swift
//  ScheduleApp
//
//  Created by Carlos Cayres on 12/05/22.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
  
    @Published var currentTab: String = "Hoje"
    @Published var openEditTask: Bool = false
    @Published var tasktitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskDeadline: Date = Date()
    @Published var taskType: String = "Basic"
    @Published var showDatePicker: Bool = false
    
    //MARK:
    
    func addTask(context: NSManagedObjectContext) -> Bool {
        let task = Task(context: context)
        task.title = tasktitle
        task.color = taskColor
        task.deadLine = taskDeadline
        task.type = taskType
        
        if let _ = try? context.save() {
            return true
        }
        
        return false
    }
    
    func resetTaskData() {
        taskType = "Basic"
        taskColor = "Yellow"
        tasktitle = ""
        taskDeadline = Date()
    }
    
}

