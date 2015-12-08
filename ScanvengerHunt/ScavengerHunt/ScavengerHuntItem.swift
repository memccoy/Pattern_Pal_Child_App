//
//  ScavengerHuntItem.swift
//  ScavengerHunt
//
//  Created by Katy Feaver on 9/10/15.
//  Copyright (c) 2015 Katy Feaver. All rights reserved.
//

import Foundation
import UIKit

class ScavengerHuntItem: NSObject, NSCoding {
    
    let name: String
    var photo: UIImage?
    var minutes:Double?
    
    var isCompleted: Bool {
        get {
            return photo != nil
        }
    }
    
    let nameKey = "name"
    let photoKey = "photo"
    let minsKey = "minutes"
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: nameKey)
        if let thePhoto = photo {
            aCoder.encodeObject(thePhoto, forKey: photoKey)
        }
        if let mins = minutes {
            aCoder.encodeObject(mins, forKey: minsKey)
        }

    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(nameKey) as! String
        photo = aDecoder.decodeObjectForKey(photoKey) as? UIImage
        minutes = aDecoder.decodeObjectForKey(minsKey) as? Double
    }
    
    init(name: String) {
        self.name = name
        self.minutes = 3.0
    }
}