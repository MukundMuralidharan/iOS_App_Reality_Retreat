//
//  MeditateMasterView.swift
//  Reality_Retreat
//
//  Created by Mukundan Muralidharan on 1/17/17.
//  Copyright © 2017 Mukundan Muralidharan. All rights reserved.
/*
    ---------
   | Read Me: |
    ---------
        Meditate Master is one of the Module in Self paced meditation and it is has 3 level speed of chanting the Mantra.
        this is a listen and repeat form.
 
 */

//

import Foundation
import UIKit
import AVFoundation


class MeditateMasterView: UIViewController{
    
    @IBOutlet weak var btnStart: UIButton!
    
    @IBOutlet weak var btnReset: UIButton!
    
    @IBOutlet weak var lblMahamantra: UILabel!
    
    @IBOutlet weak var lblMinute: UILabel!
    
    @IBOutlet weak var lblSec: UILabel!
    
    @IBOutlet weak var btnHome: UIButton!
    
    @IBOutlet weak var speed1X: UIButton!
    
    @IBOutlet weak var speed2X: UIButton!
   
    @IBOutlet weak var speedMid: UIButton!
    
    var LabelText=String()
    var timeInSec=0
    var timeInMinutes=0
    var timer=Timer()
    
    
    
    var speedButtonType=""
    
    var buttonState:Bool = true
    var audioPlayer=AVAudioPlayer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        do{
            let audiopath = Bundle.main.path(forResource: "Japam", ofType:".mp3")
            try audioPlayer=AVAudioPlayer(contentsOf: URL (fileURLWithPath: audiopath!))
            speed1X.alpha=1.0
            speedMid.alpha=0.5
            speed2X.alpha=0.5
            
        }
        catch{
            //ERROR
        }
        lblMahamantra.alpha=0
    }

   
   
    @IBAction func btnStart(_ sender: Any) {
        
        
        if buttonState==true{
            timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MeditateMasterView.action), userInfo: nil, repeats: true)
            buttonState=false
            
            speed1X.isEnabled=false
            speedMid.isEnabled=false
            speed2X.isEnabled=false
            
            
            btnStart.setTitle("Pause", for: .normal)
            audioPlayer.numberOfLoops = -1
            
            if(speedButtonType==""){
                speed1X.isEnabled=true
                speed1X.alpha=1.0
            }
            
            if(speedButtonType=="Fast"){
                audioPlayer.enableRate=true
                audioPlayer.rate=1.66666666
                audioPlayer.play()
               
                
            }else if(speedButtonType=="Slow"){
                audioPlayer.enableRate=false
                audioPlayer.play()
                
            }
            else if(speedButtonType=="Medium"){
                audioPlayer.enableRate=true
                audioPlayer.rate=1.33333338
                audioPlayer.play()
            }
            else {
                audioPlayer.enableRate=false
                audioPlayer.play()
            }
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

        speed1X.isEnabled=true
        speed1X.alpha=0.5
        
        speedMid.isEnabled=true
        speedMid.alpha=0.5
        
        speed2X.isEnabled=true
        speed2X.alpha=0.5
        
        speedButtonType=""
        print ("my speed:",speedButtonType)
    }
   
   // This function starts counting the time has seconds and Minutes counting and will run to completeing until the time ends. If need a reset the reset button can be used.
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
                speed2X.isEnabled=true
                speed1X.isEnabled=true
                speedMid.isEnabled=true
                speedMid.alpha=0.5
                speed2X.alpha=0.5
                speed1X.alpha=0.5
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
                speed2X.isEnabled=true
                speed1X.isEnabled=true
                speedMid.isEnabled=true
                speedMid.alpha=0.5
                speed2X.alpha=0.5
                speed1X.alpha=0.5
            }else{
                
                lblMinute.text=String(timeInMinutes)
                
            }
        }
        
    }

    @IBAction func btnSpeed1X(_ sender: UIButton) {
        speedButtonType=sender.currentTitle!
        print(speedButtonType)
        
        speed1X.alpha=1.0
        speed2X.isEnabled=true
        speed2X.alpha=0.5
        speedMid.isEnabled=true
        speedMid.alpha=0.5
    }
    @IBAction func btnSpeed2X(_ sender: UIButton) {
        
        speedButtonType=sender.currentTitle!
        print(speedButtonType)
        //speed2X.isEnabled=false
        speed2X.alpha=1.0
        speed1X.isEnabled=true
        speed1X.alpha=0.5
        speedMid.isEnabled=true
        speedMid.alpha=0.5
    }
    @IBAction func btnHome(_ sender: Any) {
        
        audioPlayer.stop()
    }
    
    @IBAction func btnSpeed15X(_ sender: UIButton) {
        
        speedButtonType=sender.currentTitle!
        print(speedButtonType)
        
        speedMid.alpha=1.0
        speed1X.isEnabled=true
        speed1X.alpha=0.5
        speed2X.isEnabled=true
        speed2X.alpha=0.5
    }
    
}
