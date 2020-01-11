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
    
    @IBOutlet weak var eventText: UITextField!
    
    @IBOutlet weak var importancePicker: UISegmentedControl!

    @IBOutlet weak var repeatStepper: UIStepper!
    @IBOutlet weak var repeatLabelCounter: UILabel!
    @IBOutlet weak var repeatEndTextField: UITextField!
    
    @IBAction func closeWindow(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    private var datePicker: UIDatePicker?
    private var datePicker2: UIDatePicker?
    private var datePicker3: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repeatStepper.wraps = true
        repeatStepper.autorepeat = true
        
        //MARK: - enabling textFields to show picked date
        
//        startTextField.text = "\(cellId)"
        
        //start date&time
        datePicker = UIDatePicker()
        datePicker?.minuteInterval = 5
        datePicker?.locale = NSLocale(localeIdentifier: "en-GB") as Locale
        datePicker?.datePickerMode = .dateAndTime
        datePicker?.addTarget(self, action: #selector(PopPickerViewController.dateStartChanged(datePicker:)), for: .valueChanged)
        
        //end date&time
        datePicker2 = UIDatePicker()
        datePicker2?.minuteInterval = 5
        datePicker2?.locale = NSLocale(localeIdentifier: "en-GB") as Locale
        datePicker2?.datePickerMode = .dateAndTime
        datePicker2?.addTarget(self, action: #selector(PopPickerViewController.dateEndChanged(datePicker2:)), for: .valueChanged)
        
        //repeat end date
        datePicker3 = UIDatePicker()
        datePicker3?.datePickerMode = .date
        datePicker3?.addTarget(self, action: #selector(PopPickerViewController.repeatEndTextField(datePicker3:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PopPickerViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        startTextField.inputView = datePicker
        endTextField.inputView = datePicker2
        repeatEndTextField.inputView = datePicker3
        
    }
    
    @IBAction func repeatStepperChanged(_ sender: UIStepper) {
        repeatLabelCounter.text = Int(sender.value).description
    }
    
    @IBAction func saveDate_TouchUpInside(_ sender: UIButton) { //method to fill up the dataBase
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyyMMdd"
        
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = "dd.MM.yyyy"
        
        //taking dates from our textInputs
        let dateStart = dateFormatter.date(from: startTextField.text!)!
        let dateEnd = dateFormatter.date(from: endTextField.text!)!
        
        
        if dateEnd <= dateStart {
            
            let alert = UIAlertController(title: "Error", message: "Not applicable amount", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        } else {
            
            
            //counting the duration
            let interval = Calendar.current.dateComponents([.minute], from: dateStart, to: dateEnd)
            let duration = interval.minute
            print("duration:")
            print(Int64(duration!))
            
            //id of the start date
            let dateStringExtra = dateFormatter2.string(from: dateStart)
            var dateInt = Int(dateStringExtra)
            print("start date:")
            print(dateInt!)
            
            //start time
            let timePointHour = Calendar.current.dateComponents([.hour], from: dateStart)
            let timePointMinute = Calendar.current.dateComponents([.minute], from: dateStart)
            
            //counting the hour of beginning
            let timePoint = timePointHour.hour! * 60 + timePointMinute.minute!
            print("timePoint:")
            print(timePoint)
            
            //importance value
            print("importance:")
            print(Int16(importancePicker.selectedSegmentIndex))
            
            
            //MARK: - filling up the repeated dates
            var temp = 0
            var repeatDatesArray = [Int]()
            
            //repeater amount
            let repeater = Int(repeatLabelCounter.text!)
            print("repeater:")
            print(Int16(repeater!))
            
            if repeater != 0 {
                let dateEndRepeat = dateFormatter3.date(from: repeatEndTextField.text!)!
                
                //end of repeater
                let dateEndString = dateFormatter2.string(from: dateEndRepeat)
                let repeatEndInt = Int(dateEndString)
                print("end of repeat:")
                print(repeatEndInt!)
                
                while dateInt! <= repeatEndInt! {
                    
                    let _ = dataBase.newEvent(startDate: Int64(dateInt!), startTime: Int64(timePoint), duration: Int64(duration!), eventText: eventText.text ?? "", importance: Int16(importancePicker.selectedSegmentIndex), repeatCounter: Int16(repeater!))
                    dataBase.saveContext()
                    
                    repeatDatesArray.append(dateInt!)
                    
                    dateInt = dateInt! + repeater!
                    if dateInt! % 100 > monthsLastDay[month] {
                                
                        temp = dateInt! % 100 - monthsLastDay[month]
                        dateInt = dateInt!/100 + 1
                                
                        if dateInt! % 100 > 12 {
                            dateInt = dateInt!/100
                            dateInt = dateInt! * 100 + 1 + 100
                        }
                        
                        dateInt = dateInt! * 100 + temp
                    }
   
                }
                
                dismiss(animated: true)
                
            } else {
                
                let _ = dataBase.newEvent(startDate: Int64(dateInt!), startTime: Int64(timePoint), duration: Int64(duration!), eventText: eventText.text ?? "", importance: Int16(importancePicker.selectedSegmentIndex), repeatCounter: Int16(repeater!))
                dataBase.saveContext()
                
                dismiss(animated: true)
            }
        }
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
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            
            endTextField.text = dateFormatter.string(from: datePicker2.date)
        }
        
        @objc func repeatEndTextField (datePicker3: UIDatePicker){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            
            repeatEndTextField.text = dateFormatter.string(from: datePicker3.date)
        }
    
}




