//
//  DatePickerForAppleWatch.swift
//  Date Picker For Apple Watch Library
//
//  Created by Liem Ta on 8/3/15.
//  Copyright © 2015 Liem Ta. All rights reserved.
//

import Foundation
import WatchKit
import ClockKit

class DatePickerForAppleWatch : WKInterfaceController {
	
	var monthsMap = [Int: String]()
	var daysArray = [Int]()
	var yearsArray = [Int]()
	var hoursArray = [Int]()
	var minutesArray = [Int]()
	
	var month = 1
	var day = 1
	var year = Int()
	var hour = Int()
	var minute = Int()

	let yearOffset = 1900
	
	@IBOutlet var monthPicker: WKInterfacePicker!
	@IBAction func monthPicker(value: Int) {
		month = value + 1
	}
	
	@IBOutlet var dayPicker: WKInterfacePicker!
	@IBAction func dayPicker(value: Int) {
		day = value + 1
	}
	
	@IBOutlet var yearPicker: WKInterfacePicker!
	@IBAction func yearPicker(value: Int) {
		year = yearsArray[value]
	}
	
	@IBOutlet var hourPicker: WKInterfacePicker!
	@IBAction func hourPicker(value: Int) {
		hour = value
	}
	
	@IBOutlet var minutePicker: WKInterfacePicker!
	@IBAction func minutePicker(value: Int) {
		minute = value
	}
	
	func getDateFromString() -> NSDate {
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "M d yyyy H m"
		
		let dateString = month.description + " " + day.description + " " + year.description + " " + hour.description + " " + minute.description
		let dateObtainedFromString = dateFormatter.dateFromString(dateString)
		
		if let _ = dateObtainedFromString {
			return dateObtainedFromString!
		}
		else {
			return NSDate.init(timeIntervalSinceNow: 100)
		}
	}
	
	override func awakeWithContext(context: AnyObject?) {
		// Fill months map with month abbreviations
		monthsMap[0] = "Jan"
		monthsMap[1] = "Feb"
		monthsMap[2] = "Mar"
		monthsMap[3] = "Apr"
		monthsMap[4] = "May"
		monthsMap[5] = "Jun"
		monthsMap[6] = "Jul"
		monthsMap[7] = "Aug"
		monthsMap[8] = "Sep"
		monthsMap[9] = "Oct"
		monthsMap[10] = "Nov"
		monthsMap[11] = "Dec"
		
		// Fill monthPicker with month abbreviation strings
		var monthPickerItems = [WKPickerItem]()
		for var i = 0; i < monthsMap.count; ++i {
			let pickerItem = WKPickerItem()
			pickerItem.title = monthsMap[i]
			pickerItem.caption = "Month"
			monthPickerItems.append(pickerItem)
		}
		
		monthPicker.setItems(monthPickerItems)
		
		// Create and initialize daysArray and daysPicker
		var day = 1
		
		var dayPickerItems = [WKPickerItem]()
		for var i = 0; i < 31; ++i {
			daysArray.append(day++)
			let pickerItem = WKPickerItem()
			pickerItem.title = daysArray[i].description
			pickerItem.caption = "Day"
			dayPickerItems.append(pickerItem)
		}
		
		dayPicker.setItems(dayPickerItems)
		
		for var yearIndex = 1900; yearIndex <= 2100; ++yearIndex {
			yearsArray.append(yearIndex)
		}
		var yearPickerItems = [WKPickerItem]()
		for var i = 0; i < yearsArray.count; ++i {
			let pickerItem = WKPickerItem()
			pickerItem.title = yearsArray[i].description
			pickerItem.caption = "Year"
			yearPickerItems.append(pickerItem)
		}
		
		yearPicker.setItems(yearPickerItems)
		
		// Fill hourPicker
		var hour = 0
		var hourPickerItems = [WKPickerItem]()
		for var i = 0; i < 24; ++i {
			hoursArray.append(hour++)
			let pickerItem = WKPickerItem()
			
			if hoursArray[i] <= 12 {
				pickerItem.title = NSString(format:"%.02d", hoursArray[i]).description
				pickerItem.caption = "Hour (AM)"
			}
			else {
				pickerItem.title = NSString(format:"%.02d (%.02d)", hoursArray[i], hoursArray[i] - 12).description
				pickerItem.caption = "Hour (PM)"
			}
			
			hourPickerItems.append(pickerItem)
		}
		
		hourPicker.setItems(hourPickerItems)
		
		// Fill minutePicker
		var minute = 0
		var minutePickerItems = [WKPickerItem]()
		for var i = 0; i <= 59; ++i {
			minutesArray.append(minute++)
			let pickerItem = WKPickerItem()
			pickerItem.title = NSString(format:"%.02d", minutesArray[i]).description
			pickerItem.caption = "Minute"
			minutePickerItems.append(pickerItem)
		}
		
		minutePicker.setItems(minutePickerItems)
		
		// Set picker defaults so user doesn't have to manually scroll
		setDefaultPickersOnDatePickerInterfaceController()
		
		year = yearsArray[0]
	}
	
	func setDefaultPickersOnDatePickerInterfaceController() {
		let todayDate = NSDate()
		let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
		
		let monthComponent = calendar.components(.Month, fromDate: todayDate)
		let month = monthComponent.month
		
		let dayComponent = calendar.components(.Day, fromDate: todayDate)
		let day = dayComponent.day
		
		let yearComponent = calendar.components(.Year, fromDate: todayDate)
		let year = yearComponent.year
		
		let hourComponent = calendar.components(.Hour, fromDate: todayDate)
		let hour = hourComponent.hour
		
		let minuteComponent = calendar.components(.Minute, fromDate: todayDate)
		let minute = minuteComponent.minute
		
		// These have no "0" state so they are 0 index based
		monthPicker.setSelectedItemIndex(month - 1)
		dayPicker.setSelectedItemIndex(day - 1)
		yearPicker.setSelectedItemIndex(year - yearOffset)
		// These do have a "0" state e.g. 00 hour and 00 minute, so are in their nature 0 index based
		hourPicker.setSelectedItemIndex(hour)
		minutePicker.setSelectedItemIndex(minute)
	}
}