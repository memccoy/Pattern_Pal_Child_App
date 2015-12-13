//
//  AddViewController.swift
//  ScavengerHunt
//
//  Created by Katy Feaver on 9/10/15.
//  Copyright (c) 2015 Katy Feaver. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    var tmtx:String = "";
    var tx:String = "";
    var ifedit:Bool = false
    var rowin:Int = 0
    var ip:[Int] = [192,168,2,0]
    
    @IBOutlet weak var timerTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var IP0: UITextField!
    @IBOutlet weak var IP1: UITextField!
    @IBOutlet weak var IP2: UITextField!
    @IBOutlet weak var IP3: UITextField!
    
    
    var img: UIImage?
    
    @IBOutlet weak var textField: UITextField!
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DoneItem" {
            if let name = textField.text {
                if !name.isEmpty {
                    newItem = ScavengerHuntItem(name: name)
                    if let pht = img {
                        newItem?.photo = pht
                    }
                    
                    if let timeSetStr = timerTextField.text{
                        var timeSet = (timeSetStr as NSString).doubleValue
                        
                        //check if less than 0
                        if(timeSet < 0){
                            timeSet = 0.0;
                        } else if(timeSet > 1440){ //check if total time < 24 hours
                            timeSet = 0.0;
                        }
                    
                        newItem!.minutes = timeSet
                    }
                    
                    if let ip = IP0.text{
                        newItem!.IPs[0] = Int(ip)!
                    }
                    
                    if let ip = IP1.text{
                        newItem!.IPs[1] = Int(ip)!
                    }
                    
                    if let ip = IP2.text{
                        newItem!.IPs[2] = Int(ip)!
                    }
                    
                    if let ip = IP3.text{
                        newItem!.IPs[3] = Int(ip)!
                    }
                    
                    
                }
                
            }
        }
    }
    
    var newItem: ScavengerHuntItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textField.text = tx;
        timerTextField.text = tmtx;
        photoImageView.image = img;
        IP0.text = String(ip[0]);
        IP1.text = String(ip[1]);
        IP2.text = String(ip[2]);
        IP3.text = String(ip[3]);
        
        

        // Set up views if editing an existing Meal.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        img = selectedImage
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: AnyObject) {
        // Hide the keyboard.
        textField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.

        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)

    }
    @IBAction func btnTapped(sender: AnyObject) {
        // Hide the keyboard.
        textField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
}

