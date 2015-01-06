//
//  GPSViewController.swift
//  iPhoneInfoDemo
//
//  Created by AlienLi on 14/11/13.
//  Copyright (c) 2014年 ALN. All rights reserved.
//

import UIKit
import CoreLocation

class GPSViewController: UIViewController,CLLocationManagerDelegate {
    var manager: CLLocationManager!
    
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.classForCoder()) {
            println("monitoringAvailable")
        }
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
        manager.headingFilter = kCLHeadingFilterNone
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        manager.stopUpdatingLocation()
        manager = nil
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var array:Array = locations as Array
        var location:CLLocation? = array.last as? CLLocation
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.latitudeLabel.text = "\(location!.coordinate.latitude)"
            self.longitudeLabel.text = "\(location!.coordinate.longitude)"
            self.altitudeLabel.text = "\(location!.altitude)"
        })
        
    }
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.headingLabel.text = "\(newHeading.magneticHeading)"
        })
    }
    
    func locationManager(manager: CLLocationManager!,
        didFailWithError error: NSError!){
            println("\(error)")
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
