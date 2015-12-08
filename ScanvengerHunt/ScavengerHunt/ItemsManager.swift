//
//  ItemsManager.swift
//  ScavengerHunt
//
//  Created by Katy Feaver on 9/10/15.
//  Copyright (c) 2015 Katy Feaver. All rights reserved.
//

import UIKit

class ItemsManager {
    var pp = ppstruct()
    var items = [ScavengerHuntItem] ()
    
    init (){
       unarchiveSavedItems()
    }
    
    func archivePath() -> String? {
        let directoryList = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            if let documentsPath = directoryList.first as String! {
                return documentsPath + "/ScavengerHuntItems"
            }
        
        return nil
    }
    
    func archivePathForPP() -> String? {
        let directoryList = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        if let documentsPath = directoryList.first as String! {
            return documentsPath + "/pp"
        }
        
        return nil
    }
    

    
    
    func unarchiveSavedItems() {
        if let theArchivePath = archivePath() {
            if NSFileManager.defaultManager().fileExistsAtPath(theArchivePath) {
                items = NSKeyedUnarchiver.unarchiveObjectWithFile(theArchivePath) as! [ScavengerHuntItem]
                if let theArchivePath = archivePathForPP() {
                    pp = NSKeyedUnarchiver.unarchiveObjectWithFile(theArchivePath) as! ppstruct
                }
            }
        }
    }
    
    func save() {
        if let theArchivePath = archivePath() {
            if !NSKeyedArchiver.archiveRootObject(items, toFile: theArchivePath) {
                assertionFailure("Could not save data to \(theArchivePath)")
            }
            if let theArchivePath = archivePathForPP() {
                if !NSKeyedArchiver.archiveRootObject(pp, toFile: theArchivePath) {
                    assertionFailure("Could not save data to \(theArchivePath)")
                }
            } else {
                assertionFailure("Could not determine where to save file")
            }
        }
    }
};