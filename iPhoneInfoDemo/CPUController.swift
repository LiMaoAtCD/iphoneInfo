//
//  CPUController.swift
//  iPhoneInfoDemo
//
//  Created by AlienLi on 14/12/8.
//  Copyright (c) 2014年 ALN. All rights reserved.
//

import UIKit

class CPUController: UIViewController {

    @IBOutlet weak var cpuLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var usage = CPUInfo().CPU_USAGE()
        
        println(usage)
        cpuLabel?.text = "\(usage)"
        
        // Do any additional setup after loading the view.
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
