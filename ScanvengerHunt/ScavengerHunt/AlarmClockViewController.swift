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
    @IBOutlet var dateLabel : UILabel!;
    var myManager = ItemsManager()
    
    override func viewDidLoad() {
        dateLabel.text = myManager.pp.alarm;
    }
    
    @IBAction func alarmSetButtonTapped(sender:UIButton) {
        
        //If an alarm is already set, cancel previous alarm, then continue
        removeNotification();
        
        //Getting dateformatter:
        let dateFormatter = NSDateFormatter();
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle;
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle;
        
        //Scheduling Notification:
        let dateTimeString = dateFormatter.stringFromDate(dateTimePicker.date)
        NSLog("Alarm set button tapped : %@", dateTimeString);
        scheduleLocalNotificationWithDate(dateTimePicker.date);
        
        //Changing Textbox:
        dateLabel.text = "Alarm Set For: \n" + dateTimeString;
        dateLabel.numberOfLines = 0;
        dateLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        
        //Alarm persist string
        myManager.pp.alarm = "Alarm Set For: \n" + dateTimeString;
        myManager.save();
    }
    
    @IBAction func alarmCancelButtonTapped(sender:UIButton) {
        //Logging Tapped:
        NSLog("Alarm cancel button tapped");
        
        //Changing Textbox:
        dateLabel.text = "No Alarm Set";
        dateLabel.numberOfLines = 0;
        dateLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        
        //Cancel Alarm:
        removeNotification();
    }
    
    func removeNotification() {
        myManager.pp.alarm = "No alarm set";
        myManager.save();
        UIApplication.sharedApplication().cancelAllLocalNotifications();
    }
    
    func scheduleLocalNotificationWithDate(dateTime : NSDate) {
        let dateFormatter = NSDateFormatter();
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle;
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle;
        
        let notification:UILocalNotification = UILocalNotification();
        
        notification.fireDate = dateTime
        notification.alertBody = "Time to wake up!";
        notification.soundName = "12_clock.mp3";
        notification.timeZone = NSCalendar.currentCalendar().timeZone
        notification.applicationIconBadgeNumber = 1
        
        let infoDict :  Dictionary<String,String!> = ["objectId" : "alarm_id"]
        notification.userInfo = infoDict;
        
        
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


