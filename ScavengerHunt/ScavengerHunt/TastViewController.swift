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

    let myManager = ItemsManager()
    var idx = 0
    
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
                timerLabel.text = "All tasks done";
                imgView.image = UIImage(named:"cong.png");
                taskLabel.text = "";
                nextTaskLabel.text = "";
            } else {
                taskLabel.text = "";
                timerLabel.text = "No task yet.";
                nextTaskLabel.text = "Please go to settings to add tasks.";
            }

        }
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