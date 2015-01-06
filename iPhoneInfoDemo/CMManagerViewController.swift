//
//  CMManagerViewController.swift
//  iPhoneInfoDemo
//
//  Created by AlienLi on 14/11/18.
//  Copyright (c) 2014年 ALN. All rights reserved.
//

import UIKit
import CoreMotion

class CMManagerViewController: UIViewController {
    let stepCounter = CMStepCounter()
    let altimeter:CMAltimeter = CMAltimeter()
    let manager = CMMotionManager()
    
    var error:NSError?
    var steps:Int?
    @IBOutlet weak var stepsLabel: UILabel!

    @IBOutlet weak var accelerateX: UILabel!

    @IBOutlet weak var accelerateY: UILabel!
    @IBOutlet weak var accelerteZ: UILabel!
    
    @IBOutlet weak var gyroXLabel: UILabel!
    @IBOutlet weak var gyroYLabel: UILabel!
    @IBOutlet weak var gyroZLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
//        1 stepCounter
        if CMStepCounter.isStepCountingAvailable() {
            var stepCounts:Int = 0
            
            var date:NSDate? = NSDate()
            var calendar = NSCalendar(identifier: NSGregorianCalendar)
            var components: NSDateComponents = calendar!.components(NSCalendarUnit.CalendarUnitHour|NSCalendarUnit.CalendarUnitMinute|NSCalendarUnit.CalendarUnitSecond, fromDate: NSDate())
            
            components.hour = 0
            components.minute = 0
            components.second = 0
            
            var ZeroDate = calendar!.dateFromComponents(components)
            
            stepCounter.queryStepCountStartingFrom(ZeroDate!, to: NSDate(), toQueue: NSOperationQueue.mainQueue()) { (stepCounts, error) -> Void in
                self.steps = stepCounts
            }

        } else {
            println("StepCounting is Not Available")
        }
//        2 altitude
        var altitudeData:CMAltitudeData?
        if CMAltimeter.isRelativeAltitudeAvailable() {
            println("isRelativeAltitudeAvailable")
            altimeter.startRelativeAltitudeUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (altitudeData, error) -> Void in
                println(altitudeData)
            })
            
        }else {
            println("RelativeAltitudeIsNotAvailable")
        }

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var stepCounts:Int = 0
        var error:NSError?
        var date:NSDate? = NSDate()
        
        stepCounter.startStepCountingUpdatesToQueue(NSOperationQueue.mainQueue(), updateOn: stepCounts) { (stepCounts, date, error) -> Void in
            self.stepsLabel.text = "\(self.steps! + stepCounts)"
        }
        
        
        var accelerometerData:CMAccelerometerData?
        
        if manager.accelerometerAvailable {
            manager.accelerometerUpdateInterval = 1.0
            
           if !manager.accelerometerActive {
                manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (accelerometerData, error) -> Void in
                    self.accelerateX.text = "X:\(accelerometerData!.acceleration.x)"
                    self.accelerateY.text = "Y:\(accelerometerData!.acceleration.y)"
                    self.accelerteZ.text = "Z:\(accelerometerData!.acceleration.z)"

                })
            } else {
            manager.stopAccelerometerUpdates()
            manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (accelerometerData, error) -> Void in
                self.accelerateX.text = "X:\(accelerometerData!.acceleration.x)"
                self.accelerateY.text = "Y:\(accelerometerData!.acceleration.y)"
                self.accelerteZ.text = "Z:\(accelerometerData!.acceleration.z)"
                
            })
            }
        }else {
            self.accelerteZ.text = "accelerotation is not available!"
        }
        
        
        
        if manager.gyroAvailable {
            manager.gyroUpdateInterval = 1.0
            var gyroData:CMGyroData?
            if !manager.gyroActive {
                manager.startGyroUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (gyroData, error) -> Void in
                    self.gyroXLabel.text = "\(gyroData.rotationRate.x)"
                    self.gyroYLabel.text = "\(gyroData.rotationRate.y)"
                    self.gyroZLabel.text = "\(gyroData.rotationRate.z)"
                })
            }
        }else {
            manager.stopGyroUpdates()
            manager.startGyroUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (gyroData, error) -> Void in
                self.gyroXLabel.text = "\(gyroData.rotationRate.x)"
                self.gyroYLabel.text = "\(gyroData.rotationRate.y)"
                self.gyroZLabel.text = "\(gyroData.rotationRate.z)"
            })
        }
        
        if manager.deviceMotionAvailable {}
        
        
        
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        stepCounter.stopStepCountingUpdates()
        altimeter.stopRelativeAltitudeUpdates()
        manager.stopAccelerometerUpdates()
        manager.stopGyroUpdates()
        
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
