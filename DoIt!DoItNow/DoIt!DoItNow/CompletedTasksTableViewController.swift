//
//  CompletedTasksTableViewController.swift
//  DoIt!DoItNow
//
//  Created by MobileApps on 12/2/18.
//  Copyright © 2018 MobileApps. All rights reserved.
//

import UIKit

class CompletedTasksTableViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var tasks = [Tasks]()
    var tasksDone = [Tasks]()
    let REUSE_IDENTIFIER = "taskCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let nib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: REUSE_IDENTIFIER)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTasks()
    }
    
    func loadTasks(){
        self.tasks = Tasks.loadSavedTasks()
        self.tasksDone = self.tasks.filter {
            $0.done == true
        }
        self.tableView.reloadData()
    }
    

}

    // MARK: - Table view data source

    extension CompletedTasksTableViewController: UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasksDone.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath) as! TaskTableViewCell

        
        let task = tasksDone[indexPath.row]
        
        cell.taskTitleLabel.text = task.task
        cell.taskDescriptionLabel.text = task.taskDescription
        cell.taskDueDate.text = "Task Done" + " " + task.dueDate1
        cell.doneButton.isEnabled = false
        cell.doneButton.isHidden = true

        
        return cell
    }
 
    }


extension CompletedTasksTableViewController: UITableViewDelegate {
    
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//
//    }
    
}



