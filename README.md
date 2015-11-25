# Date-Picker-for-Apple-Watch
Date Picker for Apple Watch

Apple does not provide the UIKit framework for developers to use in their Apple Watch apps. A useful API that lives in Cocoa Touch's UIKit is the DatePicker API, as shown here:

https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/Art/uidatepicker_intro_2x.png

This simple library will instantiate a date picker for you to hook into your WKInterfacePicker objects to mimic Apple's native DatePicker API. This code will: populate the months, days, and years from 1900 to 2100, inclusive. The year range can easily be changed by the developer by modifying these 2 values which live in the awakeWithContext method. There is also error handling, and will reject invalid dates such as:

Feb 30 of any year - There is never a 30th of February  
Feb 29th of any year which is not a leap year  
Jan 0, 32, 33, ... - There is no 0 day, or any days 32 and beyond  
April 31 - The library respects the non-existence of a 31st day of any month  

The getDateFromString allows you to get an NSDate object from the date that the user has set via the date pickers. This allows for nearly universal adoption of the library as NSDate is the de-facto standard for representing moments in time in iOS.

Here is a sample image of this library after hooking into WKInterfacePicker:

http://a3.mzstatic.com/us/r30/Purple6/v4/19/7e/36/197e36ac-45e6-b085-2b3e-a34d7deff911/screen390x390.jpeg
