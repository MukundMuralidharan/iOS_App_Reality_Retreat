//
//  BDroneView.swift
//  Reality_Retreat
//
//  Created by Mukundan Muralidharan on 1/17/17.
//  Copyright © 2017 Mukundan Muralidharan. All rights reserved.
/*
    ----------
   | Read Me: |
    ----------
 
       This Module is called Background Drone which allows the User to chant the Mantra on their own without any help from the instructor or from the Master. This module is also timed and the user can select the time in minutes and start chanting with the background music helping the user to concendrate on Meditation.
 */

//

import Foundation
import UIKit
import AVFoundation

class BDronView: UIViewController {
    
    var LabelText=String()
    var timeInSec=0
    var timeInMinutes=0
    var timer = Timer()
    
    var buttonState:Bool = true
    
    var audioPlayer=AVAudioPlayer()
    
    @IBOutlet weak var lblMinute: UILabel!
    
    @IBOutlet weak var lblSec: UILabel!
    
    @IBOutlet weak var btnStart: UIButton!
    
    @IBOutlet weak var btnReset: UIButton!
    
    @IBOutlet weak var lblMahamantra: UILabel!
    
    @IBOutlet weak var btnHome: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        lblMahamantra.alpha=0
        do{
            let audiopath=Bundle.main.path(forResource: "Drone", ofType: ".mp3")
            try audioPlayer=AVAudioPlayer(contentsOf: URL(fileURLWithPath: audiopath!))
        }
        catch{
            //ERROR
        }
        print(LabelText)
    }
    
    @IBAction func btnStart(_ sender: Any) {
        
        if buttonState==true{
            timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BDronView.action), userInfo: nil, repeats: true)
            buttonState=false
            btnStart.setTitle("Pause", for: .normal)
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
            self.lblMahamantra.fadeIn(completion: {
                (finished: Bool) -> Void in
                
            })
            
        }else{
            timer.invalidate()
            btnStart.setTitle("Continue", for: .normal)
            buttonState=true
            audioPlayer.stop()
        }
        

    }
    
    
    @IBAction func btnReset(_ sender: Any) {
        
        timer.invalidate()
        timeInMinutes=0
        timeInSec=0
        
        lblSec.text=("0")
        lblMinute.text=("0")
        
        btnStart.isEnabled=true
        
        btnStart.alpha=1.0
        btnStart.setTitle("Start", for: .normal)
        buttonState=true
        
        audioPlayer.stop()
        audioPlayer.currentTime=0
        lblMahamantra.alpha=0
        
    }
    
    // helper function that has the logic to calculate the time until completion.
    
    func action (){
        
        if(timeInSec<59){
            if(lblMinute.text==LabelText){
                lblSec.text=String(0)
                timer.invalidate()
                audioPlayer.stop()
                btnStart.isEnabled=true
                btnStart.setTitle("Start", for: .normal)
                lblSec.text="0"
                lblMinute.text="0"
                audioPlayer.currentTime=0
                buttonState=true
                lblMahamantra.alpha=0
            }
            timeInSec+=1
            lblSec.text=String(timeInSec)
        }else if((timeInSec==59)){
            timeInSec=0
            lblSec.text=String(timeInSec)
            timeInMinutes+=1
            lblMinute.text=String(timeInMinutes)
            let labelVal=lblMinute.text
            if(labelVal==LabelText){
                timer.invalidate()
                audioPlayer.stop()
                btnStart.setTitle("Start", for: .normal)
                audioPlayer.currentTime=0
                buttonState=true
                lblMinute.text="0"
                timeInSec=0
                timeInMinutes=0
                lblMahamantra.alpha=0
            }else{
                
                lblMinute.text=String(timeInMinutes)
                
            }
        }
        
    }

    @IBAction func btnHome(_ sender: Any) {
        
        audioPlayer.stop()
    }
    
    
}
