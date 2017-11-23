//
//  ReviewController.swift
//  Usher
//
//  Created by Mac Compus on 3/14/16.
//  Copyright © 2016 Mac Compus. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import Photos

typealias ReviewControllerCompletition = (UIImage?) -> Void

    func imagePickerViewController(croppingEnabled: Bool, completion: ReviewControllerCompletition) -> UINavigationController {

        let libraryView = LibraryManager()
        let navigationController = UINavigationController(rootViewController: libraryView)
        
        libraryView.onSelectionComplete = { asset in
            if asset != nil {
                let confirmController = ConfirmViewController(asset: asset!, allowsCropping: croppingEnabled)
                confirmController.onComplete = { image in
                    if let i = image {
                        completion(i)
                    } else {
                        libraryView.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
                confirmController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                libraryView.presentViewController(confirmController, animated: true, completion: nil)
            } else {
                completion(nil)
            }
        }
        
        libraryView.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "libraryCancel", inBundle: CameraGlobals.shared.bundle, compatibleWithTraitCollection: nil)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: libraryView, action: "dismiss")
        
        return navigationController
    }

class ReviewController : UIViewController {
    
    // MARK : -@IBOulets
    @IBOutlet weak var askForPermissionsButton: UIButton!
    @IBOutlet weak var askForPermissionsLabel: UILabel!
    @IBOutlet weak var LibraryView: UIImageView!
    
    
    // MARK : - Variables
    var croppingEnabled: Bool = false
    var libraryEnabled: Bool = true
    
    //MARK : -UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hideManager(true)
        
        let libraryViewController = imagePickerViewController(croppingEnabled) { (image) -> Void in
            self.LibraryView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        presentViewController(libraryViewController, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : -Dismiss ViewController (to close correctly the ViewController)
    @IBAction func back(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK : -ToolBox
    private func hideManager(status: Bool){
        self.askForPermissionsButton.hidden = status
        self.askForPermissionsLabel.hidden = status
    }
    
}

