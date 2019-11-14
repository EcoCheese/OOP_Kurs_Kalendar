//
//  DateSectionViewController.swift
//  OOP_Kurs
//
//  Created by Илья on 14.11.2019.
//  Copyright © 2019 Ilya Kangin. All rights reserved.
//

import UIKit

class DateSectionViewController: UIViewController {

    @IBOutlet weak var yearLabelNew: UILabel!
    @IBOutlet weak var monthLabelNew: UILabel!
    @IBOutlet weak var dateLabelNew: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yearLabelNew.text = yearString
        yearLabelNew.textColor = UIColor.systemGreen
        monthLabelNew.text = monthString
        dateLabelNew.text = dateString
        
    }
    



}
