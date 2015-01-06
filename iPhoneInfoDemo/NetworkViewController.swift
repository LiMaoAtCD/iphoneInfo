//
//  NetworkViewController.swift
//  iPhoneInfoDemo
//
//  Created by AlienLi on 14/12/3.
//  Copyright (c) 2014年 ALN. All rights reserved.
//

import UIKit
import Alamofire
import Surge

class NetworkViewController: UIViewController {

    @IBOutlet weak var netStatusLabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    
    @IBOutlet weak var InternetLabel: UILabel!
    
    @IBOutlet weak var localLabel: UILabel!
    
    @IBOutlet weak var DownloadProgress: UIProgressView!
    
    @IBOutlet weak var downloadLabel: UILabel!
    
    @IBOutlet weak var uploadProgress: UIProgressView!
    
    @IBOutlet weak var uploadLabel: UILabel!
    
    var hostReachability: Reachability?
    var internetReachability: Reachability?
    var WiFiReachability: Reachability?
    
    @IBAction func downloadTest(sender: AnyObject) {
        let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        
        var startTime:NSTimeInterval? = NSDate.timeIntervalSinceReferenceDate()
        var totalTime:NSTimeInterval?
        var totalBytes:Int64 = 0
        var speed:Double = 0.0
        Alamofire.download(.GET, "http://42.121.1.23/sta8.apk", destination)
            .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
                
                totalBytes = totalBytesRead
                var progress:Float = Float(totalBytes) / Float(totalBytesExpectedToRead)
                dispatch_async(dispatch_get_main_queue(), {() -> Void in

                    self.DownloadProgress.progress = progress
                })
            }
            .response { (request, response, _, error) in
                println(response)
                totalTime = NSDate.timeIntervalSinceReferenceDate() - startTime!
                println("\(totalBytes) Bytes downloaded in \(totalTime!)s ")
                speed = (Double(totalBytes) / totalTime!) / 1024
                println(speed)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.downloadLabel.text = "\(speed)KB/s"
                })
        }
    }
    
    @IBAction func uploadTest(sender: AnyObject) {
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.uploadLabel.text = "upload file is making..."
            
        })

//        var tempUrlString = NSTemporaryDirectory().stringByAppendingPathComponent("test.txt")
//        var tempString:String? = ""
//        var error:NSError?
//        
//        var seed = rand() % 9
//        
//        var ii = "d"
//        for var i = 0; i < 20; i++ {
//            
//            tempString? += ii
//            ii += ii
//        }
        
        
        
        
        
        
        
        
        var tempData: NSMutableData? = NSMutableData()
        
        for var i = 0 ; i < 1024 * 1024 ; i++ {
            var ii = rand() % 9
            tempData?.appendBytes(&ii, length: 1)
        }
        
        var startTime:NSTimeInterval? = NSDate.timeIntervalSinceReferenceDate()
        var totalTime:NSTimeInterval?
        var totalBytes:Int64 = 0
        var speed:Double = 0.0
        println(tempData!.length)
        Alamofire.upload(.POST, "http://115.29.5.216:8894", tempData!).progress { (byteWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
            totalBytes =  totalBytesWritten
            var currentProgress: Float = Float(totalBytes) / Float(totalBytesExpectedToWrite)
            dispatch_async(dispatch_get_main_queue(),{() -> Void in
                self.uploadLabel.text = "uploading..."
                self.uploadProgress.progress = currentProgress
            })
        }.response { (request, response, JSON, error) -> Void in
            println(error)
            totalTime = NSDate.timeIntervalSinceReferenceDate() - startTime!
            speed = (Double(totalBytes) / totalTime!) / 1024
            dispatch_async(dispatch_get_main_queue(),{() -> Void in
                self.uploadLabel.text = "\(speed) Kib/s"
            })
        }
    }
    
//        tempString?.writeToFile(tempUrlString, atomically: true, encoding: NSUTF8StringEncoding, error: &error)
//        if error != nil {
//            println(error)
//        }
//        
//        var fileUrl = NSURL.fileURLWithPath(tempUrlString)
        
        
        
       
        
//        Alamofire.upload(.POST, "http://115.29.5.216:8894", fileUrl!)
//            .progress { (byteWritten, totalByteWritten, totalBytesExpectedToWrite) -> Void in
//                totalBytes = totalByteWritten
//                var progress:Float = Float(totalBytes) / Float(totalBytesExpectedToWrite)
//                dispatch_async(dispatch_get_main_queue(), {() -> Void in
//                    self.uploadLabel.text = "uploading..."
//                    self.uploadProgress.progress = progress
//                })
//
//            }.responseString { (request, response, JSON, error) -> Void in
//                
//                totalTime = NSDate.timeIntervalSinceReferenceDate() - startTime!
//                println("\(totalBytes) Bytes uploaded in \(totalTime!)s ")
//                speed = (Double(totalBytes) / totalTime!) / 1024
//                println(speed)
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    self.uploadLabel.text = "\(speed)KB/s"
//                })
//        }


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 1
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name:kReachabilityChangedNotification , object: nil)
        
        var remoteHostName = "www.apple.com"
        
        hostReachability = Reachability(hostName: remoteHostName)
        hostReachability?.startNotifier()
        self.updateInterfaceWithReachability(self.hostReachability!)
        
        internetReachability = Reachability.reachabilityForInternetConnection()
        internetReachability?.startNotifier()
        self.updateInterfaceWithReachability(self.internetReachability!)

        WiFiReachability = Reachability.reachabilityForLocalWiFi()
        WiFiReachability?.startNotifier()
        self.updateInterfaceWithReachability(self.WiFiReachability!)


        
        var networkState:String  = ALNReachability.getNetWorkStates()
        
        println(networkState)

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func reachabilityChanged(notification: NSNotification) {
        var currentReach: Reachability? = notification.object as? Reachability
        self.updateInterfaceWithReachability(currentReach!)
        
    }
    
    func updateInterfaceWithReachability(reachability: Reachability) {
        if reachability === hostReachability! {
            println("hostReachability")
            self.configureLabel(self.hostLabel, WithReachability: self.hostReachability!)
            var netStatus: NetworkStatus = reachability.currentReachabilityStatus()
            var connectionRequired: Bool = reachability.connectionRequired()
            
            if connectionRequired {
                self.hostLabel.text = "host reachable"
            } else {
                self.hostLabel.text = "Cellular data network is active"
            }
            
            
        }
        if reachability === internetReachability {
            println("internetReachAbility")
            self.InternetLabel.text = "Reach"
        }
        if reachability === WiFiReachability{
            println("Wifi Reachablity")
            self.localLabel.text = "Reach"
        }
    }
    func configureLabel(label: UILabel, WithReachability Reach:Reachability) -> Void {
        var netStatus = Reach.currentReachabilityStatus()
        var connectionRequired  = Reach.connectionRequired()
        
        

        switch netStatus.value {
        case NotReachable.value:
            self.netStatusLabel.text = "NotReachable"
            
        case ReachableViaWWAN.value:
            self.netStatusLabel.text = "WWAN "
            
        case ReachableViaWiFi.value:
            self.netStatusLabel.text = "Wifi"
        default:
            self.netStatusLabel.text = "Unknown"
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
