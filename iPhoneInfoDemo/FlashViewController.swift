//
//  FlashViewController.swift
//  iPhoneInfoDemo
//
//  Created by AlienLi on 14/11/28.
//  Copyright (c) 2014年 ALN. All rights reserved.
//

import UIKit
import AVFoundation
class FlashViewController: UIViewController {
    var error: NSError?
    @IBOutlet weak var flashLight: UIButton!
    let session:AVCaptureSession = AVCaptureSession()
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        session.startRunning()
//        
//        if session.canSetSessionPreset(AVCaptureSessionPreset1280x720) {
//            session.sessionPreset = AVCaptureSessionPresetPhoto
//        } else {
//            println("can not set session preset")
//        }
//        
//        var device: AVCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
//        
//        if !device.hasTorch {
//            println("Error: this device doesn't  have a torch ")
//        } else {
//            if device.isTorchModeSupported(AVCaptureTorchMode.On) {
//                    let videoInput: AVCaptureDeviceInput = AVCaptureDeviceInput.deviceInputWithDevice(device, error: &error) as AVCaptureDeviceInput
//                let videoOutput: AVCaptureVideoDataOutput = AVCaptureVideoDataOutput()
//                session.addInput(videoInput)
//                session.addOutput(videoOutput)
//                if device.lockForConfiguration(&error) {
//                    
//                    if device.hasFlash && device.isFlashModeSupported(AVCaptureFlashMode.On) {
//                        device.flashMode = AVCaptureFlashMode.On
//                        
//                    }
//                    device.unlockForConfiguration()
//                }
//            }
//        }
//        
//        
        flashLight.addTarget(self, action: "toggleFlashLight", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func toggleFlashLight() -> Void {
        
        var captureDeviceClass: AnyClass? = AVCaptureDevice.self
        if let cap: AnyClass = captureDeviceClass {
            
            var device:AVCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            if device.hasTorch && device.hasFlash {
                device.lockForConfiguration(nil)
                if device.torchMode == AVCaptureTorchMode.Off {
                    device.torchMode = AVCaptureTorchMode.On
//                    device.flashMode = AVCaptureFlashMode.On
                } else {
                    device.torchMode = AVCaptureTorchMode.Off
//                    device.flashMode = AVCaptureFlashMode.Off
                }
                device.unlockForConfiguration()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
