//
//  BatteryViewController.swift
//  iPhoneInfoDemo
//
//  Created by AlienLi on 14/11/14.
//  Copyright (c) 2014年 ALN. All rights reserved.
//

import UIKit

class BatteryViewController: UIViewController {
    var Device: UIDevice?

    @IBOutlet weak var CapacityLabel: UILabel!
    @IBOutlet weak var freeCapacityLabel: UILabel!
    @IBOutlet weak var cellularSystemVersion: UILabel!
    @IBOutlet weak var CellularSystemName: UILabel!
    @IBOutlet weak var cellularLocalizedModel: UILabel!
    @IBOutlet weak var cellularModelLabel: UILabel!
    @IBOutlet weak var CellularNameLabel: UILabel!
    @IBOutlet weak var deviceOrientationLabel: UILabel!
    @IBOutlet weak var proximityLabel: UILabel!
    @IBOutlet weak var batteryStateLabel: UILabel!
    @IBOutlet weak var batteryLevelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Device = UIDevice.currentDevice()
        Device?.batteryMonitoringEnabled = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceBatteryLevelDidChanged", name: UIDeviceBatteryLevelDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceBatteryStateDidChanged", name: UIDeviceBatteryStateDidChangeNotification, object: nil)
        
        Device!.proximityMonitoringEnabled = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceProximityStateDidChanged", name: UIDeviceProximityStateDidChangeNotification, object: nil)
        
        Device?.beginGeneratingDeviceOrientationNotifications()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceOrientationDidChanged:", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var currentLevel: Float = Device!.batteryLevel
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.batteryLevelLabel.text = "\(currentLevel)"
        })
        
        var currentState = Device!.batteryState as UIDeviceBatteryState
        self.currentBatteryState(currentState)
        
        var proximityState:Bool = Device!.proximityState
        self.deviceProximityState(proximityState)
        
        var iPhoneName:String? = Device?.name
        var iPhoneModel:String? = DeviceModel.model()
        var iPhoneLocalizedModel:String? = Device?.localizedModel
        var iPhoneSystemName:String? = Device?.systemName
        var iPhoneSystemVersion:String? = Device?.systemVersion
        var freeDiskSpace:String = DeviceModel.getFreeDiskSpace()
        var totalDiskSpace:String = DeviceModel.getTotalDiskSpace()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.CellularNameLabel.text = iPhoneName!
            self.cellularModelLabel.text = iPhoneModel!
            self.cellularLocalizedModel.text = iPhoneLocalizedModel!
            self.CellularSystemName.text = iPhoneSystemName!
            self.cellularSystemVersion.text = iPhoneSystemVersion!
            self.CapacityLabel.text = "\(totalDiskSpace) GiB"
            self.freeCapacityLabel.text = "\(freeDiskSpace) GiB"
        })
        
        var iPhoneOrientation = Device?.orientation
        self.deviceOrientation()
    }
    
    deinit {
        Device?.endGeneratingDeviceOrientationNotifications()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    func deviceOrientationDidChanged(notification:NSNotification) ->Void {
        self.deviceOrientation()
        
    }
    func deviceOrientation()->Void{
        
        switch Device!.orientation  {
            
        case .Unknown:
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.deviceOrientationLabel.text = "Unknown"
            })
        case .Portrait:
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.deviceOrientationLabel.text = "Portrait"
            })
        case .PortraitUpsideDown:
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.deviceOrientationLabel.text = "PortraitUpsideDown"
            })
        case .LandscapeLeft:
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.deviceOrientationLabel.text = "LandscapeLeft"
            })
        case .LandscapeRight:
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.deviceOrientationLabel.text = "LandscapeRight"
            })
        case .FaceUp:
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.deviceOrientationLabel.text = "FaceUp"
            })
        case .FaceDown:
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.deviceOrientationLabel.text = "FaceDown"
            })
        }
    }
    
    func deviceProximityStateDidChanged() ->Void {
        var proximityState:Bool = Device!.proximityState
        self.deviceProximityState(proximityState)
    }
    
    func deviceProximityState(close:Bool) ->Void{
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if close {
                self.proximityLabel.text = "Close"
            } else {
                self.proximityLabel.text = "NotClose"
            }
        })
    }
    
    func deviceBatteryLevelDidChanged() ->Void {
        var currentLevel: Float = Device!.batteryLevel
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.batteryLevelLabel.text = "\(currentLevel)"
        })
        
        
    }
    
    func deviceBatteryStateDidChanged() -> Void {
    
        var currentState = Device!.batteryState as UIDeviceBatteryState
        self.currentBatteryState(currentState)
    }
    
    func currentBatteryState (state: UIDeviceBatteryState) ->Void {
        
        var stateString:String?
        
        switch  state {
        case .Charging:
            stateString = "Charging"
        case .Full:
            stateString = "Full"
        case .Unplugged:
            stateString = "Unplugged"
        case .Unknown:
            stateString = "Unknown"
        default:
            stateString = nil
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.batteryStateLabel.text = stateString
        })

    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        Device!.proximityMonitoringEnabled = false
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
