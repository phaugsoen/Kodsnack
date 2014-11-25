//
//  ViewController.swift
//  Kodsnack
//
//  Created by Per Haugsoen on 2014-11-14.
//  Copyright (c) 2014 Haugsoen App Development AB. All rights reserved.
//

import UIKit
import AVFoundation


let kCheckDelay = 10

let streamDir = ["Kodsnack" : "http://live.kodsnack.se/feed.json",
                 "Appsnack" : "http://live.appsnack.se/feed.json",
                 "Slashat"  : "asdasd",
                 "Apple"    : "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8",
                 "P4STH"       : "http://sverigesradio.se/topsy/direkt/701-hi-mp3.m3u"]



class ViewController: UIViewController, StatusCheckDelegate, StreamChangedDelegate
                       {

  
  @IBOutlet weak var topBar : UIToolbar!
  @IBOutlet weak var onlineStatusLbl: UILabel!
  @IBOutlet weak var pauseButton: UIBarButtonItem!
  @IBOutlet weak var playButton: UIBarButtonItem!
  
  var player : AVPlayer!
  var playerItem : AVPlayerItem!
  var jsonData : JSONData!
  var selectedStreamID = "Appsnack"
 
  var transitionOperator = TransitionOperator()
  
  @IBAction func playSomething(sender: AnyObject) {
        startListen(pauseMusic: true)
  }
  
  deinit {
    println("DEINIT, removeing observer")
    player.removeObserver(self, forKeyPath: "status")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    // Set the view bg to same as KodSnack pic bg grey #DCDCDC
    let kodSnackColor = UIColor(red:0.86,green: 0.86,blue: 0.86,alpha: 1)
    view.backgroundColor = kodSnackColor

    tryToConnect()
  }
  
  
  func notifStartListen(notification: NSNotification) {
    println("Notif in VC about start listen")
    startListen(pauseMusic: true)
    
  }
  
  
  func tryToConnect() {
    
    let t = NSDate().description
    println("\(t) Trying to connect in VC")
    
    jsonData = JSONData()
    jsonData.delegate = self
    jsonData.getStatus(streamDir[selectedStreamID]!)
  }
  
  
  
  // Protocol callbacks
  func notOnline() {
     println("NotOnLine called in VC")
    
    onlineStatusLbl.textColor = UIColor.redColor()
    onlineStatusLbl.text = "not online"
    
    
 //   if let posErrStr = self.jsonData.error_json {
 //     println("ERROR:\(posErrStr)")
 //   }
    
    var timer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector:"tryToConnect", userInfo: nil, repeats: false)
 
    
  }
  
  func dummy() {
    println("Dummy called")
  }
  
  
  
  func startListen( #pauseMusic: Bool) {
    
    if let posPlayer = player {
      if player.rate > 0.0 {
        println("already playing")
        return
      }
    }
  
    
    var error:NSError?
    var urlToCast = NSURL()
    
    println("StartListen called in VC")
    
    
    
    if pauseMusic {
      
      if let str = streamDir["P4STH"] {
        urlToCast = NSURL(string: str)!
      } else {
        fatalError("Error in stream DIR, cant cont")
      }
    } else {
      urlToCast = NSURL(string: jsonData.listen_url)!
      onlineStatusLbl.textColor = UIColor.greenColor()
      onlineStatusLbl.text = "online"
    }

    AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
    AVAudioSession.sharedInstance().setActive(true, error: nil)
    
    playerItem = AVPlayerItem(URL: urlToCast)
    player = AVPlayer(playerItem: playerItem)
    player.volume = 1
    
    let options = NSKeyValueObservingOptions.New | NSKeyValueObservingOptions.Old
    player.addObserver(self, forKeyPath: "status", options: options, context: nil)

  }


  
 
  func fadeIn() {
    
    let params = AVMutableAudioMixInputParameters()
    let timeR = CMTimeRangeMake(CMTimeMake(0,1), CMTimeMake(5, 1))
    params.setVolumeRampFromStartVolume(0.0, toEndVolume: 1.0, timeRange: timeR)
    let allParams = [params]
    
    let mix = AVMutableAudioMix()
    mix.inputParameters = allParams
    player.currentItem.audioMix = mix
  }
  
  
  
  
 
  
  
  override func observeValueForKeyPath(keyPath: String,
                                       ofObject object: AnyObject,
                                       change: [NSObject : AnyObject],
                                       context: UnsafeMutablePointer<Void>)
  {
    
    switch (keyPath) {
      case("status"):
        println("Status changed: \(change)")
        let newStatus = change[NSKeyValueChangeNewKey] as AVPlayerStatus.RawValue
        let statusCode = AVPlayerStatus.ReadyToPlay.rawValue
        if newStatus ==  statusCode {
          println("Ready to play")
          player.allowsExternalPlayback = false
          player.play()
          fadeIn()

          playButton.enabled = false
          println("Listening...")
      }
      
      
      
    default:
      super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
    }
  
  
  }
  

  @IBAction  func handleTap(recognizer:UITapGestureRecognizer) {
    
    if recognizer.numberOfTouches() == 1 {
      startListen(pauseMusic: true)
    }
  }
  
  @IBAction  func handlePinch(recognizer:UIPinchGestureRecognizer) {
    println("Pinch: \(recognizer.scale)")
    
    if recognizer.scale > 1 {
      performSegueWithIdentifier("presentNav", sender: self)
    }
    
    
  }
  
  func changedStream(name: String) {
    
    println("Changed to Stream:\(name)")
    if name != "" {
      navigationItem.title = name
      selectedStreamID = name
    }
  }
  
  
  @IBAction func pause() {
    println("Pause pressed")
    self.dismissViewControllerAnimated(true, completion: nil)
    if player.rate == 0.0 {
      player.play()
      pauseButton.enabled = true
      playButton.enabled = false
    } else {
      player.pause()
      pauseButton.enabled = false
      playButton.enabled = true
    }
  }
  
  
  @IBAction func play(sender: AnyObject) {
    println("play pressed")
    if player != nil {
      if player.rate == 0.0 {
        player.play()
        pauseButton.enabled = true
        playButton.enabled = false
      } else {
        player.pause()
        pauseButton.enabled = false
        playButton.enabled = true
      }
    }
  }
  
  
  @IBAction func retry() {
    println("Trying to reconnect")
    tryToConnect()
  }
  
  // When pushing selection VC, set self to delegate of the protocol
/* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "presentNav" {
      let dvc = segue.destinationViewController as SelectViewController
      self.modalPresentationStyle = UIModalPresentationStyle.Custom
      dvc.transitioningDelegate = self.transitionOperator
      dvc.delegate = self
    }
  }
  */
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    let toViewController = segue.destinationViewController as UIViewController
    self.modalPresentationStyle = UIModalPresentationStyle.Custom
    toViewController.transitioningDelegate = self.transitionOperator
  }
 
   /*
    let toViewController = segue.destinationViewController as UIViewController
    self.modalPresentationStyle = UIModalPresentationStyle.Custom
    toViewController.transitioningDelegate = self.transitionOperator
 */
  
}
