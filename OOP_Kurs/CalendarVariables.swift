
//MARK: Additional file fro variables

import Foundation

let date = Date()
let calendar = Calendar.current

let day = calendar.component(.day, from: date)
let weekday = calendar.component(.weekday, from: date)
let month = calendar.component(.month, from: date) - 1
let year = calendar.component(.year, from: date)
