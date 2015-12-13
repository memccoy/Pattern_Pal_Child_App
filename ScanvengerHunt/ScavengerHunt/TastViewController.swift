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
    var allDone = 1
    var myManager = ItemsManager()
    var idx = 0
    
    //time for get up, in minutes
    let getUpTime:Double = 30;

    //url for get up
    var getUpUrl:String = "http://"
    //urls for task
    var urls: [String] = []

    /*
    //urls used for test
    let getUpUrl:String = "http://localhost:5000/getUp/";
    var urls: [String] = ["http://localhost:5000/taskAtIdx0/","http://localhost:5000/taskAtIdx1/","http://localhost:5000/taskAtIdx2/","http://localhost:5000/taskAtIdx3/","http://localhost:5000/taskAtIdx4/"]
    */
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var donebtn: UIButton!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var nextTaskLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var btnImg:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //a blank task
        let newItem = ScavengerHuntItem(name: " ")
        newItem.minutes = 0.002;
        myManager.items += [newItem];
        
        btnImg = UIImage(named:"smileface.jpg")
        donebtn.setImage(btnImg, forState: .Normal)
        
        for item in myManager.items{
            var url = "http://"
            for i in 0...3 {
                if (i != 0){
                    url += "."
                }
                url += String(item.IPs[i])
            }
            url += "/$"
            urls.append(url)
        }
        
        let getUPIPArr = myManager.pp.IPs;
        for i in 0...3 {
            if (i != 0){
                getUpUrl += "."
            }
            getUpUrl += String(getUPIPArr[i])
        }
        getUpUrl += "/$"


        getup();
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
    //called evry NSTimeInterval seconds
    func timerDidEnd(timer:NSTimer){
        timeCount = timeCount - timeInterval
        if (timeCount <= 0 ) {
            allDone--;
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
        controlBulb(false, i: idx - 1);
        if (idx < myManager.items.count){//tasks not done yet
            controlBulb(true, i: idx);
            startTimer();
        } else {//all tasks done
            if(myManager.items.count > 1){//there are some tasks in setted
                if (allDone >= 0){
                    timerLabel.text = "All tasks done";
                } else {
                    timerLabel.text = "Routine complete";
                }
                imgView.image = UIImage(named:"cong.png");
                taskLabel.text = "";
                nextTaskLabel.text = "";
            
            } else {//No tasks is setted
                taskLabel.text = "";
                timerLabel.text = "No task yet.";
                nextTaskLabel.text = "Please go to settings to add tasks.";
            }
            donebtn.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        }
    }
    
    //function to go to main screen
    func pressed(sender: UIButton!) {
        NSLog("last task button tapped");
        let vc: UINavigationController = storyboard!.instantiateViewControllerWithIdentifier("main_nav_screen") as! UINavigationController;
        self.presentViewController(vc, animated: true, completion: nil);
    }
    
    func setUI(){
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
        if (i >= -1){
            var str:String = "";
            if (i >= 0){//tasks
                str = urls[i] + onOffStr;
            }else{//get up
                str = getUpUrl + onOffStr;
            }
            let url = NSURL (string: str);
            let req = NSURLRequest(URL: url!);
            if(on){
                LightsWebView.loadRequest(req);
            } else {
                turnOffWebView.loadRequest(req);
            }
            NSLog(str)
        }
    }
    
    func getup(){
        controlBulb(true, i: -1);
        taskLabel.text = "Current task: get up";
        timeCount = getUpTime;
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