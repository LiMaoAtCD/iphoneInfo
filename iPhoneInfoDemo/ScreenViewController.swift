//
//  ScreenViewController.swift
//  iPhoneInfoDemo
//
//  Created by AlienLi on 14/12/10.
//  Copyright (c) 2014年 ALN. All rights reserved.
//

import UIKit

class ScreenViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.translucent = false
        var url = NSURL(string: "http://appleservedup.com")
        var request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
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
