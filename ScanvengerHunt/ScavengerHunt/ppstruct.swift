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
    var IPs:[Int]
    
    let alarmKey = "alarm"
    let IPKey = "IPs"
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(alarm, forKey: alarmKey)
        aCoder.encodeObject(IPs, forKey: IPKey)
    }
    
    required init(coder aDecoder: NSCoder) {
        alarm = aDecoder.decodeObjectForKey(alarmKey) as! String
        IPs = aDecoder.decodeObjectForKey(IPKey) as! [Int]
    }
    
    override init() {
        self.alarm = "No alarm set."
        self.IPs = [192,168,2,99]
    }
}