//
//  MonthTableViewCell.swift
//  OOP_Kurs
//
//  Created by Ilya Kangin on 11/26/19.
//  Copyright © 2019 Ilya Kangin. All rights reserved.
//

import UIKit


class MonthTableViewCell: UITableViewCell{

    

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var timeStartLabel: UILabel!
    @IBOutlet weak var timeEndLabel: UILabel!
    
    @IBOutlet weak var importanceLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        eventNameLabel?.text =
        // Configure the view for the selected state
    }

}
