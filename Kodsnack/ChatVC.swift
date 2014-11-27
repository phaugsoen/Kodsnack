//
//  ChatVC.swift
//  kodsnack
//
//  Created by Per Haugsoen on 25/11/14.
//  Copyright (c) 2014 Haugsoen App Development AB. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UIWebViewDelegate {

 
    
    
 @IBOutlet weak var web : UIWebView!

    
    var actInd = UIActivityIndicatorView()
   
    @IBOutlet weak var newBtn : UIButton!
    
    var channelName = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
               
        web.backgroundColor =  kKodsnackBgColor 
        web.delegate = self
        loadWeb()
    }

    
    
    func loadWeb() {
        
        actInd = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
        actInd.center = self.view.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(actInd)
        actInd.startAnimating()
        
        if let requestURL = NSURL(string:kChatURLPath + channelName) {
            let request = NSURLRequest(URL:requestURL)
            web.loadRequest(request)
        }
      }
    
    
    
    @IBAction func exitPressed(sender: AnyObject?) {
    
        let alert = UIAlertController(title: "Warning",
            message: "You will leave the chat room!",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        var ok = UIAlertAction(
            title: "leave",
            style: UIAlertActionStyle.Destructive,
            handler: {(alert: UIAlertAction!) in
                
                self.dismissViewControllerAnimated(true,nil)
        })
        
        var cancel = UIAlertAction(
            title: "stay",
            style: .Default,
            handler: {(alert: UIAlertAction!) in
                println("")
        })
        
        alert.addAction(ok)
        alert.addAction(cancel)
        presentViewController(alert, animated: true, completion: nil)
     
    }
  

    
    func webViewDidFinishLoad(webView: UIWebView) {
        actInd.stopAnimating()
    }

    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
    //    println("Error loading Kiwi chat web: \(error.description)")

        actInd.stopAnimating()
        
        let alert = UIAlertController(title: "Error loading chat room",
            message: "An error occured when loading the chat",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        var ok = UIAlertAction(
            title: "ok",
            style: .Default,
            handler: {(alert: UIAlertAction!) in
                
             
        })
        
        var retry = UIAlertAction(
            title: "retry",
            style: .Default,
            handler: {(alert: UIAlertAction!) in
                self.loadWeb()
        })
        
        alert.addAction(ok)
        alert.addAction(retry)
        presentViewController(alert, animated: true, completion: nil)

    }
    
    @IBAction func handleSwipe(sender: AnyObject) {
        
        self.exitPressed(sender)
    }
    
    
    
    
    
}
