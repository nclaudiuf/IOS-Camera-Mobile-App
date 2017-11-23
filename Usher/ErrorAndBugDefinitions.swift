//
//  ErrorAndBugDefinitions.swift
//  Usher
//
//  Created by Mac Compus on 3/13/16.
//  Copyright © 2016 Mac Compus. All rights reserved.
//

import Foundation
import UIKit

//MARK : -ErrorAndBugDefinitions
class ErrorAndBugDefinitions
{
    
//MARK : -Render Alert
    class func renderAlert(error: Int) -> UIAlertController {
        var alertController = UIAlertController(title: "Usher Alert Message", message: "An Error occured.", preferredStyle: UIAlertControllerStyle.Alert)
        
        switch(error) {
        //MARK : -Error 111: Render = 1, Top = 1, Left = 1
        case 111:
            alertController = UIAlertController(title: "Usher Alert Message", message: "An Error occured rendering the element.[Defined: Error 111]", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        
            return alertController
            
        //MARK : -Error 112: Render = 1, Top = 1, Center = 2
        case 112:
            alertController = UIAlertController(title: "Usher Alert Message", message: "An Error occured rendering the element.[Defined: Error 112]", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            
            return alertController
            
        //MARK : -Error 113: Render = 1, Top = 1, Right = 3
        case 113:
            alertController = UIAlertController(title: "Usher Alert Message", message: "An Error occured rendering the element.[Defined: Error 113]", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            
            return alertController
        
        //MARK : -Testing Error
        case 0:
            alertController = UIAlertController(title: "Usher Alert Message", message: "Render Testing", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            
            return alertController
        //MARK : -Default
        default: break
        }
        
        return alertController
    }

//MARK: -BackEnd Alert
    class func backEndAlert(error: Int) -> UIAlertController {
        var alertController = UIAlertController(title: "Usher Alert Message", message: "An Error occured.", preferredStyle: UIAlertControllerStyle.Alert)
    
        switch(error) {
            //MARK : -Error 211; BackEnd = 2, ViewController = 1, Shared Preferences = 1
        case 211:
            alertController = UIAlertController(title: "Usher Alert Message", message: "An Error occured rendering the element.[Defined: Error 113]", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            
            return alertController
            
            //MARK : -Testing Error
        case 0:
            alertController = UIAlertController(title: "Usher Alert Message", message: "BackEnd Testing", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            
            return alertController
            //MARK : -Default
        default: break
        }
        
        return alertController
    }
    
}
