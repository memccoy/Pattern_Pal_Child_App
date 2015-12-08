//
//  ppstruct.swift
//  ScavengerHunt
//
//  Created by lt on 12/8/15.
//  Copyright © 2015 Katy Feaver. All rights reserved.
//

import Foundation

class ppstruct: NSObject, NSCoding {
    
    var alarm: String

    let alarmKey = "alarm"
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(alarm, forKey: alarmKey)
    }
    
    required init(coder aDecoder: NSCoder) {
        alarm = aDecoder.decodeObjectForKey(alarmKey) as! String
    }
    
    override init() {
        self.alarm = "No alarm set."
    }
}