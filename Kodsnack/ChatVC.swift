//
//  ChatVC.swift
//  kodsnack
//
//  Created by Per Haugsoen on 25/11/14.
//  Copyright (c) 2014 Haugsoen App Development AB. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    
 @IBOutlet weak var web : UIWebView!

    var URLPath = "http://kiwiirc.com/client/irc.freenode.net/Appsnack"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let requestURL = NSURL(string:URLPath)
        let request = NSURLRequest(URL:requestURL!)
        
        web.loadRequest(request)
        
    }

    @IBAction func exitPressed(sender: AnyObject?) {
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
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
