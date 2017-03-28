//
//  UIView.swift
//  Reality_Retreat
//
//  Created by Mukundan Muralidharan on 1/17/17.
//  Copyright © 2017 Mukundan Muralidharan. All rights reserved.
/*
    ----------
   | Read Me: |
    ----------
 
       This is an extension class written for the UIView to help animate the text showing on different modules.
 */

//

import Foundation
import UIKit

public extension UIView {
    
     // This is function helps to fade In the test with a small delay.
    
    func fadeIn(duration: TimeInterval = 6.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
}
