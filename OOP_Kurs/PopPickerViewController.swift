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
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    
    private var datePicker: UIDatePicker?
    private var datePicker2: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        datePicker?.addTarget(self, action: #selector(PopPickerViewController.dateStartChanged(datePicker:)), for: .valueChanged)
        
        datePicker2 = UIDatePicker()
        datePicker2?.datePickerMode = .dateAndTime
        datePicker2?.addTarget(self, action: #selector(PopPickerViewController.dateEndChanged(datePicker2:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PopPickerViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        startTextField.inputView = datePicker
        endTextField.inputView = datePicker2
        
//        titleLabel.text = "\(dateString + " " + monthString + " " + yearString)"
//        datePicker.date = 

    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    
    @objc func dateStartChanged (datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        startTextField.text = dateFormatter.string(from: datePicker.date)

    }
    
    @objc func dateEndChanged (datePicker2: UIDatePicker){
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd.MM.yyyy HH:mm"
        
        endTextField.text = dateFormatter2.string(from: datePicker2.date)

    }

    
    @IBAction func saveDate_TouchUpInside(_ sender: UIButton) {
        
        
        
        dismiss(animated: true)
    }
    

}
