//
//  JSONData.swift
//  Kodsnack
//
//  Created by Per Haugsoen on 2014-11-14.
//  Copyright (c) 2014 Haugsoen App Development AB. All rights reserved.
//

import Foundation
import UIKit


protocol StatusCheckDelegate {
  func notOnline()
  func startListen( #pauseMusic: Bool)
}


class JSONData {
  
  
  var delegate : StatusCheckDelegate?

  var listen_url = "NOT SET"
  var title = "NO TITLE"
  var error_string : String?
  var error_json : String?
  
  init() {
    
  }
  
  func getStatus(url_string: String) {
    println("Asking \(url_string) for json")
    
    let request = NSURLRequest(URL: NSURL(string: url_string)!)
    
    NSURLConnection.sendAsynchronousRequest(
      request,
      queue: NSOperationQueue.mainQueue())
      {
        (response: NSURLResponse!, data: NSData!, error: NSError!)
        -> Void in
        if error != nil {
        println("OPS, an error occured")
          println(error.description)
        return
        }
        
        var error: NSError?
        
        let parsed: AnyObject? =
        NSJSONSerialization.JSONObjectWithData(
          data,
          options: NSJSONReadingOptions.AllowFragments,
          error: &error)
        
        if error == nil {
          println("Data returned from JSON req:\(parsed)")
          
          // we got the params, set them in this object
          // and let VC use it for AV connection
          if let parsed = parsed as? [String:AnyObject] {
            if let icestats = parsed["icestats"] as? NSDictionary {
              if let source = icestats["source"] as? NSDictionary {
               
                self.listen_url = source["listenurl"] as String
                self.title = source["listenurl"] as String
              //  if let title = source["title"] as? String {
              //    self.listen_url = title
              //    self.title = title
            
                  // Notify VC it can start to connect
                  self.delegate?.startListen(pauseMusic: false)
                  return
              //  }
              }
            }
          }
          println("ERROR, could not get all ice params")
          self.error_string = "ERROR, could not get all ice params"
          
          // Kanske ny egen func för detta senare???
          self.delegate?.notOnline()
          
        } else {
          // It seams icecast returns malformed JSON if not live/online,
          // so for now, if malformed eq NOT ONLINE
        
          
          self.error_json = NSString(data: data, encoding: NSASCIIStringEncoding)
          
         // println("\(error)")
          self.error_string = error?.localizedDescription
          self.delegate?.notOnline()
      //    println("RAW:\(data.description)")
    
                  
          
          
        }
 
    }
  }
}
