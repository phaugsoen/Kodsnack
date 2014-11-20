//
//  SelectViewController.swift
//  Kodsnack
//
//  Created by Per Haugsoen on 2014-11-18.
//  Copyright (c) 2014 Haugsoen App Development AB. All rights reserved.
//

import UIKit


protocol StreamChangedDelegate {
  func changedStream(name: String)
}

class SelectViewController: UIViewController {

  
  var delegate : StreamChangedDelegate?
  
    override func viewDidLoad() {
        super.viewDidLoad()
  }


 
  @IBAction func cancelStream(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  
  @IBAction func buttonPressed(sender: UIButton) {
    
    
    if let posName = sender.titleLabel?.text {
      println("Button \(posName) pressed right now")
      delegate?.changedStream(posName)
      self.dismissViewControllerAnimated(true, completion: nil)
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
