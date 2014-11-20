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
  var selectedStreamID = "Kodsnack"
  var fakeListening = false
  
 // var urlToCast = NSURL(string: Apple_test_stream )
  

  
  @IBAction func playSomething(sender: AnyObject) {
    
    startListenP4()
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    // Set the view bg to same as KodSnack pic bg grey #DCDCDC
    let kodSnackColor = UIColor(red:220,green: 220,blue: 220,alpha: 1)
 //   view.backgroundColor = kodSnackColor

  tryToConnect()
    
    // try to check the status of pause button and change it state
   // pauseButton. = UIBarButtonSystemItem.Pause
  }
  
  func tryToConnect() {
    
    let t = NSDate().description
    println("\(t) Trying to connect in VC")
    
    jsonData = JSONData()
    jsonData.delegate = self
    jsonData.getStatus(streamDir[selectedStreamID]!)
  }
  
  
  /*

  [UIView animateWithDuration:duration delay:0
  usingSpringWithDamping:damping initialSpringVelocity:0.0f
  options:0 animations:^{
  primaryConstraint.constant = 0;
  [self.view layoutIfNeeded];
  } completion:nil];

*/
  
  func bounce() {
    
//    UIView.animateWithDuration(2.0, delay: 0.3, usingSpringWithDamping: 0.4, initialSpringVelocity: 2.0, options: 0, animations: <#() -> Void##() -> Void#>, completion: <#((Bool) -> Void)?##(Bool) -> Void#>)
    
  }
  
  
  
  // Protocol callbacks
  func notOnline() {
     println("NotOnLine called in VC")
    
    onlineStatusLbl.textColor = UIColor.redColor()
    onlineStatusLbl.text = "not online"
    
    
    if let posErrStr = self.jsonData.error_json {
      println("ERROR:\(posErrStr)")
    }
    
    var timer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector:"tryToConnect", userInfo: nil, repeats: false)
 
    fakeListen()
    
  }
  
  func startListen() {
    println("StartListen called in VC")
    
    onlineStatusLbl.textColor = UIColor.greenColor()
    onlineStatusLbl.text = "online"
    
    var error:NSError?
    var urlToCast = NSURL(string: jsonData.listen_url )
 //   var urlToCast = NSURL(string: "http://sverigesradio.se/topsy/direkt/164-hi-mp3.m3u")
    AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)

    AVAudioSession.sharedInstance().setActive(true, error: nil)
    
    playerItem = AVPlayerItem(URL: urlToCast)
    player = AVPlayer(playerItem: playerItem)
    
    let options = NSKeyValueObservingOptions.New | NSKeyValueObservingOptions.Old
    player.addObserver(self, forKeyPath: "status", options: options, context: nil)
  }

  
  func fakeListen() {
    
    if !fakeListening {
      fakeListening = true
      println("fake listening")
      var error:NSError?
      var urlToCast = NSURL(string: "http://sverigesradio.se/topsy/direkt/164-hi-mp3.m3u")
      AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
      AVAudioSession.sharedInstance().setActive(true, error: nil)
      playerItem = AVPlayerItem(URL: urlToCast)
      player = AVPlayer(playerItem: playerItem)
    }
  }
  
  
  func startListenP4() {
    println("StartListenP4 called in VC")
    var error:NSError?
    var urlToCast = NSURL(string: "http://sverigesradio.se/topsy/direkt/164-hi-mp3.m3u")
    AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
    AVAudioSession.sharedInstance().setActive(true, error: nil)
    
    playerItem = AVPlayerItem(URL: urlToCast)
    player = AVPlayer(playerItem: playerItem)
    
    let options = NSKeyValueObservingOptions.New | NSKeyValueObservingOptions.Old
    player.addObserver(self, forKeyPath: "status", options: options, context: nil)
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
          playButton.enabled = false
          println("Listening...")
      }
      
    default:
      super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
    }
  
  
  }
  

  @IBAction  func handleTap(recognizer:UITapGestureRecognizer) {
    
    if recognizer.numberOfTouches() == 1 {
      startListenP4()
    }
  }
  
  @IBAction  func handlePinch(recognizer:UIPinchGestureRecognizer) {
    println("Pinch: \(recognizer.scale)")
    
    if recognizer.scale > 1 {
      performSegueWithIdentifier("streamChoice", sender: self)
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
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "streamChoice" {
      let dvc = segue.destinationViewController as SelectViewController
      dvc.delegate = self
    }
  }
  
  
}
