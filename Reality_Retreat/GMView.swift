//
//  GMView.swift
//  Reality_Retreat
//
//  Created by Mukundan Muralidharan on 1/17/17.
//  Copyright © 2017 Mukundan Muralidharan. All rights reserved.
/*
      --------
    | Read Me: |
      --------
       GuidedMeditation will allow the user to follow 6-3-2 pattern (12 mins) of Meditation by the instructor.
       
*/
//

import Foundation
import UIKit
import AVFoundation

class GMView: UIViewController{
    
    @IBOutlet weak var btnStart: UIButton!
    
    @IBOutlet weak var btnReset: UIButton!
    
    @IBOutlet weak var lblMahamantra: UILabel!
    
    var buttonState: Bool = true
    
    var audioPlayer=AVAudioPlayer()
    
    var LabelText = String()
    
    var timer=Timer()
    
    override func viewDidLoad() {
        do{
            let audiopath=Bundle.main.path(forResource: "GM", ofType: ".mp3")
            try audioPlayer=AVAudioPlayer(contentsOf: URL(fileURLWithPath: audiopath!))
            
            
        }
        catch{
            //ERROR
        }
        
        
        lblMahamantra.alpha=0
    }

    @IBAction func btnStart(_ sender: Any) {
        
        if buttonState==true{
            timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GMView.action), userInfo: nil, repeats: true)
            buttonState=false
            btnStart.setTitle("Pause", for: .normal)
            audioPlayer.numberOfLoops = 1
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
    
    @IBAction func btnHome(_ sender: Any) {
        audioPlayer.stop()
    }
    @IBAction func btnReset(_ sender: Any) {
        
        timer.invalidate()
        
        btnStart.isEnabled=true
        
        btnStart.alpha=1.0
        btnStart.setTitle("Start", for: .normal)
        buttonState=true
        audioPlayer.stop()
        lblMahamantra.alpha=0
        audioPlayer.currentTime=0
    }
    
    func action (){
        
        if(!audioPlayer.isPlaying){
            btnStart.setTitle("Start", for: .normal)
            lblMahamantra.alpha=0
            audioPlayer.currentTime=0
        }
    }
        
}
