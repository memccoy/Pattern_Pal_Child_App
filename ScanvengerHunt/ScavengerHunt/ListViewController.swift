//
//  ListViewController.swift
//  ScavengerHunt
//
//  Created by Katy Feaver on 9/10/15.
//  Copyright (c) 2015 Katy Feaver. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let myManager = ItemsManager()
    
    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info : [String: AnyObject]) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedItem = myManager.items[indexPath.row]
            let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
            selectedItem.photo = photo
            dismissViewControllerAnimated(true, completion: { () -> Void in
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
        }
    }
    */
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editTask" {
            let editController = segue.destinationViewController as! AddViewController
            if let selectedCell = sender as? UITableViewCell{
                let indexPath = tableView.indexPathForCell(selectedCell)
                let selectedItem = myManager.items[indexPath!.row]
                editController.tmtx = String(Double(selectedItem.minutes!))
                editController.tx = selectedItem.name
                editController.img = selectedItem.photo
                editController.ifedit = true;
                editController.rowin = indexPath!.row;
                for index in 0...3 {
                    editController.ip[index] = selectedItem.IPs[index];
                }
            }
        }
    }
    
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        if segue.identifier == "DoneItem" {
            let addVC = segue.sourceViewController as! AddViewController
            if addVC.ifedit {
                var totalTime: Double;
                totalTime = 0;
                var oldTime: Double;
                oldTime = myManager.items[addVC.rowin].minutes!;
                
                for(var i = 0; i < myManager.items.count; ++i) {
                    
                    totalTime = totalTime + myManager.items[i].minutes!;
                    
                }
                
                print(totalTime-oldTime);
                print(addVC.newItem?.minutes);
                
                if(totalTime + (addVC.newItem?.minutes)! - oldTime > 1440){
                    //do nothing
                } else{
                    myManager.items[addVC.rowin] = addVC.newItem!
                }
                
                myManager.save()
                self.tableView.reloadData()
            }else{
                if let newItem = addVC.newItem {
                    var totalTime: Double;
                    totalTime = 0;
                    for(var i = 0; i < myManager.items.count; ++i) {
                        
                        totalTime = totalTime + myManager.items[i].minutes!;
                        
                    }
                    
                    print(totalTime);
                    print(newItem.minutes);
                    
                    if(totalTime + newItem.minutes! > 1440) {
                        
                        newItem.minutes = 0.0;
                        
                    }
                    
                    if(myManager.items.count > 50){
                        
                        //do nothing
                        
                    } else  {
                        
                        myManager.items += [newItem]
                        myManager.save()
                        let indexPath = NSIndexPath(forRow: myManager.items.count - 1, inSection: 0)
                        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    }
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myManager.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        navigationItem.rightBarButtonItem = editButtonItem();
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath) as UITableViewCell
        
        let item = myManager.items[indexPath.row]
        
        if item.isCompleted {
            //cell.accessoryType = .Checkmark
            cell.imageView?.image = item.photo
        } else {
            //cell.accessoryType = .None
            cell.imageView?.image = nil
        }
        var textStr = item.name;
        if let minDoub = item.minutes{
            textStr += "            "
            textStr +=  String(minDoub)
            textStr += " mins"
        }
        
        cell.textLabel?.text = textStr
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            myManager.items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            myManager.save()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let movedObject = myManager.items[sourceIndexPath.row]
        myManager.items.removeAtIndex(sourceIndexPath.row)
        myManager.items.insert(movedObject, atIndex: destinationIndexPath.row)
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(myManager.items)")
        myManager.save()
        // To check for correctness enable: self.tableView.reloadData()
    }
}