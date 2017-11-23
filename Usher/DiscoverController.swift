//
//  DiscoverController.swift
//  Usher
//
//  Created by Mac Compus on 3/14/16.
//  Copyright © 2016 Mac Compus. All rights reserved.
//

import UIKit

class DiscoverController : UIViewController {
    
    
    //MARK : -UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : -Dismiss ViewController (to close correctly the ViewController)
    @IBAction func back(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }

}

