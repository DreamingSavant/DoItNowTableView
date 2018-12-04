//
//  TaskTableViewCell.swift
//  DoIt!DoItNow
//
//  Created by MobileApps on 12/2/18.
//  Copyright © 2018 MobileApps. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskTitleLabel: UILabel!
    
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    
    @IBOutlet weak var taskDueDate: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!
    
    
    var tasks = [Tasks]()
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.layoutIfNeeded()
    }
    
}
