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
  
    func alarmSetButtonTapped(sender:UIButton) {
        NSLog("Alarm set button tapped");
    }
    
    func alarmCancelButtonTapped(sender:UIButton) {
        NSLog("Alarm cancel button tapped");
    }
}


