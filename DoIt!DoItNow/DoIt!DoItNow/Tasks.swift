//
//  Tasks.swift
//  DoIt!DoItNow
//
//  Created by MobileApps on 12/2/18.
//  Copyright © 2018 MobileApps. All rights reserved.
//

import Foundation


class Tasks: NSObject, NSCoding {
    
        // MARK: Persistence Directory
    
        static var FileDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        static let FilePath: URL = Tasks.FileDirectory.appendingPathComponent("savedTasks")
    
    
    var task: String
    
    var taskDescription: String
    
    var dueDate1: String
    
    var done: Bool = false
    
    
    init(task: String, taskDescription: String, dueDate1: String) {
        self.task = task
        self.taskDescription = taskDescription
        self.dueDate1 = dueDate1
        
    }
    
    // MARK: NSCoding
    
    struct CodingKeys {
        static let task = "task"
        static let taskDescription = "taskDescription"
        static let dueDate1 = "dueDate1"
        static let done = "done"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.task, forKey: CodingKeys.task)
        aCoder.encode(self.taskDescription, forKey: CodingKeys.taskDescription)
        aCoder.encode(self.dueDate1, forKey: CodingKeys.dueDate1)
        aCoder.encode(self.done, forKey: CodingKeys.done)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.task = aDecoder.decodeObject(forKey: CodingKeys.task) as! String
        self.taskDescription = aDecoder.decodeObject(forKey: CodingKeys.taskDescription) as! String
        self.dueDate1 = aDecoder.decodeObject(forKey: CodingKeys.dueDate1) as! String
        self.done = aDecoder.decodeBool(forKey: CodingKeys.done)
    }
}

// MARK: Persistence Methods, NSKeyedArchiver

extension Tasks {
    static func saveTasks(_ tasks: [Tasks]){
        let taskData = NSKeyedArchiver.archivedData(withRootObject: tasks)
        
        do{
            try taskData.write(to: Tasks.FilePath)
        }
        catch {
            print("Could not write data: \(error)")
        }
    }
    
    static func loadSavedTasks() -> [Tasks] {
        guard let savedData = NSData(contentsOf: Tasks.FilePath) else {
            print("No saved data")
            return []
        }
        do {
            let tasks = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as! [Tasks]
            return tasks
        }
        catch {
            print("Error found while unarchiving: \(error)")
            return []
        }
    }
}


extension Tasks {
    func toggleDone() {
        self.done = !self.done
    }
}

extension String {
    func date(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: self)
        return date
    }
    
}
