//
//  ViewController.swift
//  RR
//
//  Created by Mukundan Muralidharan on 1/17/17.
//  Copyright © 2017 Mukundan Muralidharan. All rights reserved.
/*
   -----------
   | Read Me  |
   ------------
 
          ViewController class is created for the home page where we select the type of 
          Meditation such as "Guided Mediation" or  "Self Paced Meditation".
          Once the meditation type is selected depending on the what selected the processes changes.
 
          If Self Paced Mediation selected it then further displays the time and different type of self Paced
          Meditations such as, "Meditate with the Master" and "Background drone". Once the type and time is select 
          the app jumps to the selected meditation type.

*/
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var btnGuidedMeditation: UIButton!
    
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var btnselfpaced: UIButton!
    
    @IBOutlet weak var btnsubtract: UIButton!
    
    @IBOutlet weak var lblTimeCounter: UILabel!
    
    @IBOutlet weak var lbllisten: UILabel!
    @IBOutlet weak var btnMM: UIButton!
    
    @IBOutlet weak var btnBdrone: UIButton!
    
    
    @IBOutlet weak var lblOnurown: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblSelectMT: UILabel!
    
    var tMinutes=2    // variable type to be 2 as default
    var timeVal=2
    var btnSelection=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
    
    
        
        
        lblTime.isHidden=true
        btnMM.isHidden=true
        btnBdrone.isHidden=true
        
        btnAdd.isHidden=true
        btnsubtract.isHidden=true
        
        
        btnBdrone.isEnabled=true
        btnMM.isEnabled=true
        
        lblTimeCounter.isHidden=true
        lblSelectMT.isHidden=true
        lbllisten.isHidden=true
        lblOnurown.isHidden=true
        
        //check idle time.
        
        UIApplication.shared.isIdleTimerDisabled=true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // function is called once the app gets interrupted by a phone call
    
    func appMovedToBackground(){
        exit(0)
    }
    
    //once the selecting selfPaced Meditation it starts to show related inform which is hidden.
    
    @IBAction func btnselfpaced(_ sender: Any) {
        
        lblTime.isHidden=false
        lblTimeCounter.isHidden=false
        lblSelectMT.isHidden=false
        lblOnurown.isHidden=false
        lbllisten.isHidden=false
        
        btnsubtract.isHidden=false
        btnAdd.isHidden=false
        btnMM.isHidden=false
        btnBdrone.isHidden=false
    }

    
    // This action function is created to add time in Minutes until it reached 45 minutes and it stops adding time.
    
    @IBAction func btnAdd(_ sender: Any) {
        
        if(tMinutes<45) {
            tMinutes+=1
            lblTimeCounter.text=String (tMinutes)
            btnBdrone.isEnabled=true
            btnMM.isEnabled=true
            
            timeVal=tMinutes
            
            btnBdrone.alpha=1.0
            btnMM.alpha=1.0
            btnsubtract.isEnabled=true
            
        }else{
            btnAdd.isEnabled=false
        }
    }
    
    
   // This action fucntion is created to subtract the time in Minutes until it reaches 1 and will stop subtracting the time.
    
    @IBAction func btnsubtract(_ sender: Any) {
        if(tMinutes>1){
            tMinutes-=1;
            lblTimeCounter.text=String (tMinutes)
            btnAdd.isEnabled=true
            
            timeVal=tMinutes
            
            if(tMinutes==1){
                btnsubtract.isEnabled=false

            }
            
        }
    }
    
   
    
    @IBAction func btnMM(_ sender: Any) {
        btnSelection=btnMM.currentTitle!
    }
    
    
    
    @IBAction func btnBdrone(_ sender: Any) {
        btnSelection=btnBdrone.currentTitle!
    }
    
    // Segue which finds out what type of self Meditation is seleted and will move to that page along with the timer value as argument passed to selected Meditation.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(btnSelection=="Meditate with the Master "){
            let DestinationViewController:MeditateMasterView=segue.destination as! MeditateMasterView
            
            DestinationViewController.LabelText = String (timeVal)
            print(timeVal)
        }else if(btnSelection=="Background Drone "){
            let DestinationViewController:BDronView=segue.destination as! BDronView
            DestinationViewController.LabelText=String (timeVal)
        }
    }
    
}

