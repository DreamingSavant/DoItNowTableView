//
//  CreateATaskViewController.swift
//  DoIt!DoItNow
//
//  Created by MobileApps on 12/2/18.
//  Copyright © 2018 MobileApps. All rights reserved.
//

import UIKit

class CreateATaskViewController: UIViewController {


    
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    @IBOutlet weak var taskDescriptionTextField: UITextField!
    
    @IBOutlet weak var taskDueDateTextField: UITextField!
    
    
    let datePicker = UIDatePicker()
    var delegate: CreateTask!
    var taskTitle: String = ""
    var taskDescription: String = ""
    var date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createDatePicker()
    }

    func createDatePicker(){
        //setting up the datepickerview
        datePicker.datePickerMode = .dateAndTime
        
        taskDueDateTextField.inputView = datePicker
        
        //creating a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //add a done button 
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([doneButton], animated: true)
        
        taskDueDateTextField.inputAccessoryView = toolbar
        }
    
    func doneClicked(){
        //format the date in textfield 
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        taskDueDateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    @IBAction func submitTaskButtonPressed(_ sender: Any) {
       self.taskTitle = taskTitleTextField.text!
       self.taskDescription = taskDescriptionTextField.text!
        self.date = taskDueDateTextField.text!
        self.delegate?.makeTask(task: taskTitle, description: taskDescription, dueDate1: date)
        
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   
}

