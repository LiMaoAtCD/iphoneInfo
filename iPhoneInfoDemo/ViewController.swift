//
//  ViewController.swift
//  iPhoneInfoDemo
//
//  Created by AlienLi on 14/11/13.
//  Copyright (c) 2014年 ALN. All rights reserved.
//

import UIKit
import LocalAuthentication


class ViewController: UIViewController,UITableViewDelegate {
    var dataSource:tableViewDataSource?
    let identifier:String = "Cell"
    var error:NSError? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tableView :UITableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        
        self.view.addSubview(tableView)
        
        dataSource = tableViewDataSource()
        dataSource?.identifier = identifier
        
        tableView.delegate = self
        tableView.dataSource = dataSource!
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        var context:LAContext = LAContext()
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error){
            var access:Bool
            
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Test", reply: { (access, error) -> Void in
    
                if access {
                    println("Yep")
                } else {
                    println("Nop")
                }
            })
            
        } else {
            println(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        switch indexPath.row {
        case 0:
            var gpsController:GPSViewController = sb.instantiateViewControllerWithIdentifier("GPSViewController") as GPSViewController
            self.navigationController?.pushViewController(gpsController, animated: true)
            
        case 1:
            var batteryInfo:BatteryViewController = sb.instantiateViewControllerWithIdentifier("BatteryViewController") as BatteryViewController
            self.navigationController?.pushViewController(batteryInfo, animated: true)
        
        case 2:
            var motionController = sb.instantiateViewControllerWithIdentifier("CMManagerViewController") as CMManagerViewController
            self.navigationController?.pushViewController(motionController, animated: true)
        case 3:
            var telephony = sb.instantiateViewControllerWithIdentifier("CTTelephonyViewController") as CTTelephonyViewController
            self.navigationController?.pushViewController(telephony, animated: true)
        case 4:
            var flashController = sb.instantiateViewControllerWithIdentifier("FlashViewController") as FlashViewController
            self.navigationController?.pushViewController(flashController, animated: true)
        case 5:
            var networkController = sb.instantiateViewControllerWithIdentifier("NetworkViewController") as NetworkViewController
            self.navigationController?.pushViewController(networkController, animated: true)
        case 6:
            var cpuController = sb.instantiateViewControllerWithIdentifier("CPUController") as CPUController
            self.navigationController?.pushViewController(cpuController, animated: true)
        case 7:
            var screenController = sb.instantiateViewControllerWithIdentifier("ScreenViewController") as ScreenViewController
            self.navigationController?.pushViewController(screenController, animated: true)
        default:
            println("")
        }
    }

}

class tableViewDataSource: NSObject,UITableViewDataSource {
    var identifier:String?
    let typeArray:[String] = ["GPS,Alti&Heading","Battery,Compass&SystemInfo","CoreMotion","CoreTelephony","flash","NetworkStatus","CPU","Screen"]
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier!, forIndexPath: indexPath) as? UITableViewCell
        
        cell?.textLabel?.text = typeArray[indexPath.row]
        
        return cell!
    }
    
    
}




