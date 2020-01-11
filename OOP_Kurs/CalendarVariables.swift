
//MARK: Additional file for variables

import Foundation

let date = Date()
let calendar = Calendar.current

let day = calendar.component(.day, from: date)
var weekday = calendar.component(.weekday, from: date) - 1
var month = calendar.component(.month, from: date) - 1
var year = calendar.component(.year, from: date)

var monthsLastDay = [31,28,31,30,31,30,31,31,30,31,30,31]


let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

var currentMonth = String()

var numOfEmptyBox = Int() //amount of
var nextNumOfEmptyBox = Int()
var prevNumOfEmptyBox = 0
var direction = 0
var positionIndex = 0
var leapYear = 3
var dayCounter = 0
var dateSelection = -1
var selectedDate = 0
var cellId = 0

var minMonth = String()
var plusMonth = String()

