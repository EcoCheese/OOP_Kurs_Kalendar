//
//  ViewController.swift
//  OOP_Kurs
//
//  Created by Ilya Kangin on 10/13/19.
//  Copyright © 2019 Ilya Kangin. All rights reserved.
//

import UIKit
//import CoreData

var dateString = ""
var monthString = ""
var yearString = ""


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate{
    
    var eventArr = [Event]()
    

    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var addEventButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        currentMonth = months[month]
        if(currentMonth == "January"){
            minMonth = months[11]
        } else {
            minMonth = months[month-1]
        }
        
        if(currentMonth == "December"){
            plusMonth = months[0]
        } else {
             plusMonth = months[month+1]
        }
        
        monthLabel.text = "\(currentMonth)"
        yearLabel.text = "\(year)"
        yearLabel.textColor = .systemGreen
        
        if weekday == 0 {
            weekday = 7
        }
        
    
        backButton.setTitle("\(minMonth)", for: .normal)
        nextButton.setTitle("\(plusMonth)", for: .normal)

        getStartDatePosition()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
 
    //  main function that counts the position of the 1st day of the month and emptyBoxes that are made to fill up the void
    
    // NB: can be used in future to create the full calendar table
    
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
    
    // MARK: - Buttons
    
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
        
    }
    
    //MARK: - Add event
    @IBAction func onAddEventClicked(_ sender: Any) {
        //MARK: very important variables
        
        cellId = selectedDate + (month+1)*100 + year*10000
        tableView.reloadData()
        
//        print(selectedDate, month+1, year)
   
    }
    
    
    //function to return the amount of boxes that shоuld be made

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
        
        if currentMonth == months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && day == indexPath.row + 1 - numOfEmptyBox{

            cell.Rectangle.isHidden = false
            cell.frameAppear()

            cell.DateLabel.textColor = .label
            cell.DateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        }
            
        if dateSelection == indexPath.row {
            
//            print("currentMonth: \(currentMonth) = \(months[calendar.component(.month, from: date) - 1])")
//            print("year: \(year) = \(calendar.component(.year, from: date))")
//            print("day: \(day) = \(indexPath.row + 1 - numOfEmptyBox)")
//            print("dateSelection: \(dateSelection) = \(indexPath.row)")
            
            cellId = selectedDate + (month+1)*100 + year*10000
            
            DispatchQueue.main.async {
                self.eventArr = dataBase.fetchAll(predicate: NSPredicate(format: "startDate = %@", "\(cellId)"))
                print(cellId)
                print(self.eventArr)
                self.tableView.reloadData()
            }
//            print(cellId)
            
            
            cell.Rectangle.isHidden = false
            cell.rectangleAppear()
            cell.DateLabel.textColor = UIColor.white
            cell.DateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        }
        
        
        
        return cell
    }
    
    //function of selecting items in the collection
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        

        
        dateString = "\(indexPath.row - positionIndex + 1)"
        monthString = "\(currentMonth)"
        yearString = "\(year)"
        
        dateSelection = indexPath.row
        selectedDate = indexPath.row - positionIndex + 1
        
        tableView.reloadData()
        Calendar.reloadData()
    }
    
    //MARK: - Table View
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50))
        view.backgroundColor = .white
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "\(selectedDate) " + currentMonth + " \(year)"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

//        view.addSubview(button)

        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataBase.delete(model: eventArr[indexPath.row])
        eventArr.remove(at: indexPath.row)
        dataBase.saveContext()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return eventArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cellPredicate = NSPredicate(format: "\(cellId)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! MonthTableViewCell
        
        
        

        let event = eventArr[indexPath.row]
        cell.eventNameLabel.text = event.eventText
        
        if event.importance == 1 {
            cell.importanceLabel.text = "!"
        } else if event.importance == 2 {
            cell.importanceLabel.text = "!!"
        } else {
            cell.importanceLabel.text = ""
        }
        

        
        let hourTime = event.startTime/60
        let minuteTime = event.startTime%60
        if minuteTime < 10 {
            cell.timeStartLabel.text = "\(hourTime):0\(minuteTime)"
        } else {
            cell.timeStartLabel.text = "\(hourTime):\(minuteTime)"
        }
        
        let endHourTime = (event.startTime + event.duration)/60
        let endMinuteTime = (event.startTime + event.duration)%60
        if endMinuteTime < 10 {
            cell.timeEndLabel.text = "\(endHourTime):0\(endMinuteTime)"
        } else {
            cell.timeEndLabel.text = "\(endHourTime):\(endMinuteTime)"
        }
        
        
        
        
        
        return cell
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        
        return CGSize(width: bounds.width/8, height: 30)
    }
}

