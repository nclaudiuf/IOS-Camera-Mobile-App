//
//  ViewController.swift
//  Usher
//
//  Created by Mac Compus on 3/11/16.
//  Copyright © 2016 Mac Compus. All rights reserved.
//

import UIKit
import CameraManager

class ViewController: UIViewController {
    
    // MARK : - Constants
    let cameraManager = CameraManager()
    
    // MARK : - @IBOutlets
    @IBOutlet weak var cameraView : UIView!
    @IBOutlet weak var cameraButton : UIButton!
    @IBOutlet weak var flashModeButton : UIButton!
    @IBOutlet weak var changeCameraButton: UIButton!
    @IBOutlet weak var askForPermissionsButton: UIButton!
    @IBOutlet weak var askForPermissionsLabel: UILabel!
    @IBOutlet weak var imageCapturedView: UIImageView!
    @IBOutlet weak var imageCapturedButton: UIButton!
    
    
    // MARK : -Variables
    var imageFlsah : [UIImage] = [
    UIImage(named: "FlashButton.Gold.png")!,
    UIImage(named: "FlashButton.Gold.png")!,
    UIImage(named: "FlashButton.Gold.png")!
    ]
    
    var imageChangeCamera : [UIImage] = [
        UIImage(named: "SwitchCameraButton.Gold.png")!,
        UIImage(named: "SwitchCameraButton.Gold.png")!
    ]
    
    var croppingEnabled: Bool = false
    
    // MARK : -KEY
    static let usherKey = "Usher_PreferenceKey"
    
    // MARK : UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraManager.showAccessPermissionPopupAutomatically = false
        hideManager(true, number: 3)

        do {
            if readData().size.width != 0 {
                hideManager(false, number: 2)
                self.imageCapturedView.image = self.readData()
            }
        }
        catch {
              self.presentViewController(ErrorAndBugDefinitions.renderAlert(0), animated: true, completion: nil) //Testing
        }
        
       
        let currentCameraState = cameraManager.currentCameraStatus()
        
        if currentCameraState == .NotDetermined {
            hideManager(false, number: 1)
        } else if (currentCameraState == .Ready) {
            addCameraToView()
        }
        if !cameraManager.hasFlash {
            flashModeButton.enabled = false
            flashModeButton.setTitle("No flash", forState: .Normal)
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.hidden = true
        cameraManager.resumeCaptureSession()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        cameraManager.stopCaptureSession()
    }

    
    // MARK : ViewController
    private func addCameraToView(){
        cameraManager.addPreviewLayerToView(cameraView, newCameraOutputMode: CameraOutputMode.StillImage)
        cameraManager.showErrorBlock = { [weak self] (erTitle: String, erMessage: String) -> Void in
            
            let alertController = UIAlertController(title: erTitle, message: erMessage, preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in } ))
            
            self?.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK : @ IBActions 
    @IBAction func changeFlashMode(sender: UIButton) {
        switch (cameraManager.changeFlashMode()) {
        case .Off:
            do {
                if imageFlsah.isEmpty == false {
                    sender.setImage(imageFlsah[1], forState: .Normal)
                }
            }
            catch {
                self.presentViewController(ErrorAndBugDefinitions.renderAlert(111), animated: true, completion: nil)
            }
            
        case .On:
            do {
                if imageFlsah.isEmpty == false {
                    sender.setImage(imageFlsah[1], forState: .Normal)
                }
            }
            catch {
                self.presentViewController(ErrorAndBugDefinitions.renderAlert(111), animated: true, completion: nil)
            }

        case .Auto:
            do {
                if imageFlsah.isEmpty == false {
                    sender.setImage(imageFlsah[2], forState: .Normal)
                }
            }
            catch {
                self.presentViewController(ErrorAndBugDefinitions.renderAlert(111), animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func captureButtonTapped(sender: UIButton) {        
        cameraManager.capturePictureWithCompletition({ (image, error) -> Void in
            if let capturedImage = image {
                self.imageCapturedView.image = capturedImage
                self.writeData(image!)
            }
        })
    }
    
    @IBAction func imageCapturedView(sender: UIButton) {
            let vc: ImageViewController? = self.storyboard?.instantiateViewControllerWithIdentifier("ImageVC")
                as? ImageViewController
            if let validVC: ImageViewController = vc {
                
                print("Display Test 2")
                
                validVC.image = readData()
                self.navigationController?.pushViewController(validVC, animated: true)
            }
    }
    
    @IBAction func outputModeButtonTapped(sender: UIButton) {
        cameraManager.cameraOutputMode = cameraManager.cameraOutputMode == CameraOutputMode.StillImage ?
        CameraOutputMode.StillImage : CameraOutputMode.StillImage
        
        cameraButton.selected = true
    }
    
    @IBAction func changeCameraDevice(sender: UIButton) {
        cameraManager.cameraDevice = cameraManager.cameraDevice == CameraDevice.Front ? CameraDevice.Back : CameraDevice.Front
        switch(cameraManager.cameraDevice) {
        case .Front:
            do {
                if imageChangeCamera.isEmpty == false {
                    sender.setImage(imageChangeCamera[1], forState: .Normal)
                }
            }
            catch {
                self.presentViewController(ErrorAndBugDefinitions.renderAlert(112), animated: true, completion: nil)
            }
        case .Back:
            do {
                if imageChangeCamera.isEmpty == false {
                    sender.setImage(imageChangeCamera[0], forState: .Normal)
                }
            }
            catch {
                self.presentViewController(ErrorAndBugDefinitions.renderAlert(112), animated: true, completion: nil)
            }
        }
    }
    
    // MARK : -ToolBox
    private func hideManager(status: Bool, number: Int){
        if number == 1 {
            self.askForPermissionsButton.hidden = status
            self.askForPermissionsLabel.hidden = status
        } else if number == 2 {
            imageCapturedView.hidden = status
            imageCapturedButton.hidden = status
        } else if number == 3 {
            hideManager(status, number: 1)
            hideManager(status, number: 2)
        }
    }
    
    @IBAction func askForCameraPermissions(sender: UIButton) {
        cameraManager.askUserForCameraPermissions({ permissionGranted in
            self.askForPermissionsButton.hidden = true
            self.askForPermissionsLabel.hidden = true
            self.askForPermissionsButton.alpha = 0
            self.askForPermissionsLabel.alpha = 0
            if permissionGranted {
                self.addCameraToView()
            }
        })
    }
    
    internal override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    internal override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return UIStatusBarAnimation.Slide
    }
    
    // MARK : -Shared Preferences
    
    @IBAction func writeData(image: UIImage) {
        let imageData = UIImageJPEGRepresentation(image, 1)
        let relativePath = "Usher_\(NSDate.timeIntervalSinceReferenceDate()).jpg"
        let path = self.documentsPathForFileName(relativePath)
        imageData?.writeToFile(path, atomically: true)
        NSUserDefaults.standardUserDefaults().setObject(imageData, forKey: ViewController.usherKey)
        NSUserDefaults.standardUserDefaults().synchronize()

    }

    private func readData() -> UIImage {
        let prefs = NSUserDefaults.standardUserDefaults()
        if let imageData = prefs.objectForKey(ViewController.usherKey) as? NSData {
            let storedData = UIImage.init(data: imageData)
            
           // print("Test ", storedData)
            
            return storedData!
        }
        return UIImage()
    }
    
    private func documentsPathForFileName(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
        let path = paths[0] as String;
        let fullPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(name)
        var valuePath = fullPath.absoluteString
        return valuePath
    }
    
    
    // MARK : -Access Views
    
    @IBAction func accessReview(sender: UIButton) {
        let viewControllerObject = self.storyboard?.instantiateViewControllerWithIdentifier("Review")
        self.navigationController?.pushViewController(viewControllerObject!, animated: true)
    }
    
    @IBAction func accessDiscover(sender: UIButton) {
        let viewControllerObject = self.storyboard?.instantiateViewControllerWithIdentifier("Discover")
        self.navigationController?.pushViewController(viewControllerObject!, animated: true)
    }
    
    @IBAction func accessSetting(sender: UIButton) {
        let viewControllerObject = self.storyboard?.instantiateViewControllerWithIdentifier("Setting")
        self.navigationController?.pushViewController(viewControllerObject!, animated: true)
    }
    
}

