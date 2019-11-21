//
//  ViewController.swift
//  OOP_Kurs
//
//  Created by Ilya Kangin on 10/13/19.
//  Copyright © 2019 Ilya Kangin. All rights reserved.
//

import UIKit

var dateString = ""
var monthString = ""
var yearString = ""

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var addEventButton: UIButton!
    
    
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var monthsLastDay = [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMonth = String()
    
    var numOfEmptyBox = Int() //amount of
    var nextNumOfEmptyBox = Int()
    var prevNumOfEmptyBox = 0
    var direction = 0
    var positionIndex = 0
    var leapYear = 3
    var dayCounter = 0
    var dateSelection = -1
    
    var minMonth = String()
    var plusMonth = String()
    
    //Function to make main.storyboard to appear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = months[month]
        minMonth = months[month-1]
        plusMonth = months[month+1]
        
        
        monthLabel.text = "\(currentMonth)"
        yearLabel.text = "\(year)"
        yearLabel.textColor = .systemGreen
        
        if weekday == 0 {
            weekday = 7
        }
        
        
        backButton.setTitle("\(minMonth)", for: .normal)
        nextButton.setTitle("\(plusMonth)", for: .normal)

        getStartDatePosition()
    }
 
    //  main function that counts the postion of the 1st day of the month and emptyBoxes that are made to fill up the void
    
    // NB: can be used in future to create the full calendar list
    
    func getStartDatePosition() {
        switch direction {
        case 0:
            numOfEmptyBox = weekday
            dayCounter = day
            while dayCounter > 0 {
                numOfEmptyBox = numOfEmptyBox - 1
                dayCounter = dayCounter - 1

                if numOfEmptyBox == 0 {
                     numOfEmptyBox = 7
                }
            }
            if numOfEmptyBox == 7 {
                numOfEmptyBox = 0
            }
            positionIndex = numOfEmptyBox

             
        case 1...:
            nextNumOfEmptyBox = (positionIndex + monthsLastDay[month])%7
            positionIndex = nextNumOfEmptyBox
        case -1:
            prevNumOfEmptyBox = (7 - (monthsLastDay[month] - positionIndex)%7)
            if prevNumOfEmptyBox == 7 {
                prevNumOfEmptyBox = 0
            }
            positionIndex = prevNumOfEmptyBox
        default:
            fatalError()
        }
    }
    
    // function of the button, that scrolls through monthes forward
    
    @IBAction func Next(_ sender: Any) {
        
        
        
        dateSelection = -1
        
        switch currentMonth {
        case "December":
            direction = 1
            
            month = 0
            year += 1
            
            
            if leapYear < 5 {
                leapYear += 1
            }
            
            if leapYear == 4 {
                monthsLastDay[1] = 29
            }
            
            if leapYear == 5 {
                leapYear = 1
                monthsLastDay[1] = 28
            }
            
            
            
            getStartDatePosition()
            
            currentMonth = months[month]
            
            monthLabel.text = "\(currentMonth)"
            yearLabel.text = "\(year)"
            
            minMonth = months[11]
            plusMonth = months[1]
            
            backButton.setTitle("\(minMonth)", for: .normal)
            nextButton.setTitle("\(plusMonth)", for: .normal)
            
            Calendar.reloadData()
            
            
        case "November":
            
            direction = 1
            
            getStartDatePosition()
            
            month += 1
            
            
            currentMonth = months[month]
            
            monthLabel.text = "\(currentMonth)"
            yearLabel.text = "\(year)"
            
            minMonth = months[10]
            plusMonth = months[0]
            
            backButton.setTitle("\(minMonth)", for: .normal)
            nextButton.setTitle("\(plusMonth)", for: .normal)
            
            Calendar.reloadData()
            
            
        default:
            
            direction = 1
            
            getStartDatePosition()
            
            month += 1
            
            currentMonth = months[month]
            
            monthLabel.text = "\(currentMonth)"
            yearLabel.text = "\(year)"
            
            minMonth = months[month-1]
            plusMonth = months[month+1]
            
            backButton.setTitle("\(minMonth)", for: .normal)
            nextButton.setTitle("\(plusMonth)", for: .normal)
            
            Calendar.reloadData()
        }
    }
    
    // function of the button, that scrolls through monthes backward
    
    @IBAction func Back(_ sender: Any) {
        
        dateSelection = -1
        
        switch currentMonth {
        case "January":
            direction = -1
            
            month = 11
            year -= 1
            
            
            if leapYear > 0 {
                leapYear -= 1
            }
            
            if leapYear == 0 {
                monthsLastDay[1] = 29
                leapYear = 4
            } else {
                monthsLastDay[1] = 28
            }
            
            getStartDatePosition()
            
            currentMonth = months[month]
            
            monthLabel.text = "\(currentMonth)"
            yearLabel.text = "\(year)"
            
            minMonth = months[month-1]
            plusMonth = months[0]
            
            backButton.setTitle("\(minMonth)", for: .normal)
            nextButton.setTitle("\(plusMonth)", for: .normal)
            
            Calendar.reloadData()
            
        case "February":
            
            direction = -1
            
            month -= 1
            
            getStartDatePosition()
            
            currentMonth = months[month]
            
            monthLabel.text = "\(currentMonth)"
            yearLabel.text = "\(year)"
            
            minMonth = months[11]
            plusMonth = months[1]
            
            backButton.setTitle("\(minMonth)", for: .normal)
            nextButton.setTitle("\(plusMonth)", for: .normal)
            
            Calendar.reloadData()
            
        default:
            direction = -1
            
            month -= 1
            
            getStartDatePosition()
            
            currentMonth = months[month]
            
            monthLabel.text = "\(currentMonth)"
            yearLabel.text = "\(year)"
            
            
            minMonth = months[month-1]
            plusMonth = months[month+1]
            
            backButton.setTitle("\(minMonth)", for: .normal)
            nextButton.setTitle("\(plusMonth)", for: .normal)
            
            Calendar.reloadData()
        }
        
//        minMonth = months[month-1]
//        plusMonth = months[month+1]
//
//        backButton.setTitle("\(minMonth)", for: .normal)
//        nextButton.setTitle("\(plusMonth)", for: .normal)
    }
    
    
    @IBAction func onAddEventClicked(_ sender: Any) {
        print(dateSelection, currentMonth, year)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        
        guard let destinationViewController = mainStoryboard.instantiateViewController(withIdentifier: "PopPickerViewController") as? PopPickerViewController else{
            print("No viewController")
            return
        }
        
//        if dateSelection != -1 {
            navigationController?.pushViewController(destinationViewController, animated: true)
//        } else {
//            print("out of reach")
//        }
        
        
    }
    
    
    //function to return the amount of boxes that shuld be made

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch direction {
        case 0:
            return monthsLastDay[month] + numOfEmptyBox
        case 1...:
            return monthsLastDay[month] + nextNumOfEmptyBox
        case -1:
            return monthsLastDay[month] + prevNumOfEmptyBox
        default:
            fatalError()
        }
        
    }
    
    //function that fills appropriate boxes with numbers, so it can start creating the calendar
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.DateLabel.textColor = .label
        cell.DateLabel.font = UIFont.systemFont(ofSize: 13)
        
        cell.Rectangle.isHidden = true
        
        if cell.isHidden {
            cell.isHidden = false
        }
        
        switch direction {
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - numOfEmptyBox)"
        case 1:
            cell.DateLabel.text = "\(indexPath.row + 1 - nextNumOfEmptyBox)"
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - prevNumOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.DateLabel.text!)! < 1 {
            cell.isHidden = true
        }
        
        switch indexPath.row {
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(cell.DateLabel.text!)! > 0{
                cell.DateLabel.textColor = UIColor.systemRed
            }
        default:
            break
        }
        
        if currentMonth == months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 - numOfEmptyBox == day{
            
            cell.Rectangle.isHidden = false
            cell.frameAppear()
            
            cell.DateLabel.textColor = .label
            cell.DateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        }
            
         if dateSelection == indexPath.row {
            
            
            cell.Rectangle.isHidden = false
            cell.rectangleAppear()
            cell.DateLabel.textColor = UIColor.white
            cell.DateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        dateString = "\(indexPath.row - positionIndex + 1)"
        monthString = "\(currentMonth)"
        yearString = "\(year)"
        
        
        performSegue(withIdentifier: "DateView", sender: self)
        
        dateSelection = indexPath.row
        
        
        
        collectionView.reloadData()
        
        
        
    }

}

