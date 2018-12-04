//
//  ViewController.swift
//  DoIt!DoItNow
//
//  Created by MobileApps on 12/1/18.
//  Copyright © 2018 MobileApps. All rights reserved.
//

import UIKit

class TaskTableViewController: UIViewController {

    //create reusable identifier for custom view cell
    let REUSE_IDENTIFIER = "taskCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    //Initiate the model class
    var tasks = [Tasks]()
    var tasksDone = [Tasks]()
    //initial number of tasks
    var numberOfTasks = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self
//        self.tableView.delegate = self
        
        //introduce the custom view cell nib
        let nib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        // register nib as reuse identifier
        self.tableView.register(nib, forCellReuseIdentifier: REUSE_IDENTIFIER)
        
        // set cell size
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        
        //Loding saved data
        loadArchivedTasks()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    
    @IBAction func createTaskButtonPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateATaskViewController") as! CreateATaskViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func loadArchivedTasks() {
        DispatchQueue.global().async { [unowned self] in
            self.tasks = Tasks.loadSavedTasks()
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }



}

// Mark - DataSource

extension TaskTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count > numberOfTasks ? tasks.count : numberOfTasks
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath) as! TaskTableViewCell
        
        let task = tasks[indexPath.row]
        
        cell.taskTitleLabel.text = task.task
        cell.taskDescriptionLabel.text = task.taskDescription
        
        
        // had to convert string date to date to compare current with due date
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let currentDate = dateFormatter.string(from: date)
        
        let date1 = currentDate.date(format: dateFormatter.dateFormat)!
        let date2 = task.dueDate1.date(format: dateFormatter.dateFormat)!
        
        print(date1)
        print(date2)
        if date1 < date2 {
            print("Hahahaha")
            cell.taskDueDate.text = "Due Date:" + " " + String(describing: task.dueDate1)
            cell.taskDueDate.textColor = .black
        } else {
            print("NOOOOOOOO!")
            cell.taskDueDate.text = "Due Date:" + " " + String(describing: task.dueDate1)
            cell.taskDueDate.textColor = .red
        }
        
        cell.doneButton.tag = indexPath.row
        cell.doneButton.addTarget(self, action: #selector(doneButtonTapped(_:)), for: .touchUpInside )
        
        return cell
    }
    
    @objc func doneButtonTapped(_ sender: UIButton){
        print("It Works!!!!!")
        print(sender.tag)
        let task = self.tasks[sender.tag]
        task.toggleDone()
        Tasks.saveTasks(self.tasks)
//        Tasks.saveTasks(self.tasksDone)
        
//        self.tasks.remove(at: sender.tag)
        self.tableView.reloadData()
        
    }

    
}

extension TaskTableViewController: CreateTask {
    func makeTask(task: String, description: String, dueDate1: String) {
        let newTask = Tasks(task: task, taskDescription: description, dueDate1: dueDate1)
        self.tasks.append(newTask)
        Tasks.saveTasks(self.tasks)
        self.tableView.reloadData()
    }
}

extension TaskTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //var task = self.tasks
            tasks.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            Tasks.saveTasks(self.tasks)
        }
        self.tableView.reloadData()
    }
    
   
    
}


