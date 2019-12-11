//
//  MonthTableViewCell.swift
//  OOP_Kurs
//
//  Created by Ilya Kangin on 11/26/19.
//  Copyright © 2019 Ilya Kangin. All rights reserved.
//

import UIKit

struct eventData {
    var eventStart = Date()
    var eventEnd = Date()
    var eventText = String()
}

class MonthTableViewCell: UITableViewCell{

    

    @IBOutlet weak var eventNameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        eventNameLabel?.text
        // Configure the view for the selected state
    }

}
