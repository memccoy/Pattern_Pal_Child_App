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
    
    @IBOutlet var dateTimePicker : UIDatePicker?;
  
    @IBAction func alarmSetButtonTapped(x:UIButton) {
        NSLog("Alarm set button tapped");
    }
    
    @IBAction func alarmCancelButtonTapped(x:UIButton) {
        NSLog("Alarm cancel button tapped");
    }
}


