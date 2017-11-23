//
//  ImageViewController.swift
//  Usher
//
//  Created by Mac Compus on 3/13/16.
//  Copyright © 2016 Mac Compus. All rights reserved.
//

import UIKit

// MARK : -ImageViewController 
class ImageViewController : UIViewController
{
    //MARK : -Variables
    var image : UIImage?
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK : -UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false       
        
        if let validImage = self.image {
            self.imageView.image = validImage
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.   
    }
    
    //MARK : -Dismiss ViewController (to close correctly the ViewController) 
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}