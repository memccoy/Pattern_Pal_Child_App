//
//  AlarmClockViewController.swift
//  ScavengerHunt
//
//  Created by Madeline McCoy on 10/11/15.
//  Copyright © 2015 Katy Feaver. All rights reserved.
//

import Foundation
import UIKit

class AlarmClockViewController : UIViewController {
    
    @IBOutlet var dateTimePicker : UIDatePicker!;
    
    @IBAction func alarmSetButtonTapped(sender:UIButton) {
        
        let dateFormatter = NSDateFormatter();
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle;
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle;
        
        let dateTimeString = dateFormatter.stringFromDate(dateTimePicker.date)
        NSLog("here");
        NSLog("Alarm set button tapped : %@", dateTimeString);
        scheduleLocalNotificationWithDate(dateTimePicker.date);
        
    }
    
    @IBAction func alarmCancelButtonTapped(sender:UIButton) {
        NSLog("Alarm cancel button tapped");
    }
    
    func scheduleLocalNotificationWithDate(dateTime : NSDate) {
        let dateFormatter = NSDateFormatter();
        let notification:UILocalNotification = UILocalNotification();
        
        //var cal = NSCalendar.currentCalendar();
        
        notification.fireDate = NSDate(timeIntervalSinceNow: 8)
        notification.alertBody = "Time to wake up!";
        notification.soundName = "12_clock.mp3";
        notification.timeZone = NSCalendar.currentCalendar().timeZone
        
        /* Action settings */
        notification.hasAction = true
        notification.alertAction = "Open"
        
        let fireDateString = dateFormatter.stringFromDate(notification.fireDate!)
        let dateTimeString = dateFormatter.stringFromDate(dateTime)
        
        NSLog("Alarm date time : %@", dateTimeString);
        NSLog("Alarm fire date : %@", fireDateString);
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification);
        
    }
    
    
    
}


