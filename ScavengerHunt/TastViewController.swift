//
//  TastViewController.swift
//  ScavengerHunt
//
//  Created by Katy Feaver on 10/11/15.
//  Copyright © 2015 Katy Feaver. All rights reserved.
//

import Foundation
import UIKit

class TaskViewController : UIViewController {

    @IBOutlet weak var turnOffWebView: UIWebView!
    @IBOutlet weak var LightsWebView: UIWebView!
    let myManager = ItemsManager()
    var idx = 0
    var urls: [String] = ["http://192.168.2.9/$", "http://192.168.2.10/$",  "http://192.168.2.11/$", "http://192.168.2.12/$", "http://192.168.2.13/$"]
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var donebtn: UIButton!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var nextTaskLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var btnImg:UIImage!
    
    override func viewDidLoad() {
        btnImg = UIImage(named:"smileface.jpg")
        donebtn.setImage(btnImg, forState: .Normal)
        super.viewDidLoad();
        getup();
        //nextTask();
    }
    
    var timer = NSTimer()
    let timeInterval:NSTimeInterval = 0.05 // update timer every .05 seconds
    var timeCount:NSTimeInterval = 10.0
    
    @IBAction func doneBtnTapped(sender: AnyObject) {
        nextTask();
    }
    
    
    func timeString(time:NSTimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = time - Double(minutes) * 60
        return String(format:"%02i:%02i", minutes, Int(seconds))
    }
    
    //MARK: Instance Methods
    func timerDidEnd(timer:NSTimer){
        // first timer iteration
        //
        timeCount = timeCount - timeInterval
        if (timeCount <= 0 ) {
            nextTask();
        }else {
            timerLabel.text =  timeString(timeCount)
        }
    }
    
    func startTimer (){
        if (!timer.valid) {
            timeCount = 60 * myManager.items[idx].minutes!;
            setUI();
            timerLabel.text = timeString(timeCount)
            idx++;
            timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "timerDidEnd:", userInfo: "Task Done!", repeats: true)
            
        }
    }
    
    func nextTask(){
        timer.invalidate();
        if (idx < myManager.items.count){
            startTimer();
        } else {
            if(myManager.items.count > 0){
                controlBulb(false, i: idx - 1);
                timerLabel.text = "All tasks done";
                imgView.image = UIImage(named:"cong.png");
                taskLabel.text = "";
                nextTaskLabel.text = "";
                donebtn.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
            } else {
                taskLabel.text = "";
                timerLabel.text = "No task yet.";
                nextTaskLabel.text = "Please go to settings to add tasks.";
            }

        }
    }
    
    func pressed(sender: UIButton!) {
        NSLog("last task button tapped");
        let vc: UINavigationController = storyboard!.instantiateViewControllerWithIdentifier("main_nav_screen") as! UINavigationController;
        self.presentViewController(vc, animated: true, completion: nil);
    }
    
    func setUI(){
        controlBulb(false, i: idx - 1);
        controlBulb(true, i: idx);
        taskLabel.text = "Current task: " + myManager.items[idx].name
        imgView.image = myManager.items[idx].photo;
        if (idx + 1 < myManager.items.count){
            nextTaskLabel.text = "Next task: " + myManager.items[idx + 1].name;
        } else {
            nextTaskLabel.text = " ";
        }
    }
    
    func controlBulb(on:Bool, i:Int){
        var onOffStr:String = "2";
        if (on){
           onOffStr = "1";
        }
        if (i >= 0){
            let str:String = urls[i] + onOffStr;
            let url = NSURL (string: str);
            let req = NSURLRequest(URL: url!);
            if(on){
                LightsWebView.loadRequest(req);
            } else {
                //LightsWebView.loadRequest(req);
                turnOffWebView.loadRequest(req);
            }
        }
    }
    
    func getup(){
        taskLabel.text = "Current task: get up";
        timeCount = 30;
        timerLabel.text = timeString(timeCount)
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "timerDidEnd:", userInfo: "Task Done!", repeats: true)
        imgView.image = UIImage(named:"getUp.jpg");
        if (myManager.items.count > 0){
            nextTaskLabel.text = "Next task: " + myManager.items[0].name;
        } else {
            nextTaskLabel.text = " ";
        }
    }
    
}