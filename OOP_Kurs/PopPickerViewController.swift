//
//  PopPickerViewController.swift
//  OOP_Kurs
//
//  Created by Илья on 18.11.2019.
//  Copyright © 2019 Ilya Kangin. All rights reserved.
//

import UIKit

class PopPickerViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        datePicker.date = 

    }

    
    @IBAction func saveDate_TouchUpInside(_ sender: UIButton) {
        
        
        
        dismiss(animated: true)
    }
    

}
