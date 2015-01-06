//
//  CTTelephonyViewController.swift
//  iPhoneInfoDemo
//
//  Created by AlienLi on 14/11/18.
//  Copyright (c) 2014年 ALN. All rights reserved.
//

import UIKit
import CoreTelephony

class CTTelephonyViewController: UIViewController {
    
    @IBOutlet weak var isoCountryCode: UILabel!
    
    @IBOutlet weak var mobileCountryCode: UILabel!
    
    @IBOutlet weak var networkCode: UILabel!
    
    @IBOutlet weak var carriorName: UILabel!
    
    @IBOutlet weak var allowVOIP: UILabel!
    
    let info:CTTelephonyNetworkInfo = CTTelephonyNetworkInfo()
    var carrier:CTCarrier?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        carrier = info.subscriberCellularProvider
       
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.isoCountryCode.text = self.carrier!.isoCountryCode
        self.mobileCountryCode.text = self.carrier!.mobileCountryCode
        self.networkCode.text = self.carrier!.mobileNetworkCode
        
        if self.carrier!.allowsVOIP {
            self.allowVOIP.text = "Yes"
            
        } else{
            
            self.allowVOIP.text = "No"
        }
        self.carriorName.text = self.carrier!.carrierName
        
        println("\(self.carrier!.isoCountryCode)")
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
