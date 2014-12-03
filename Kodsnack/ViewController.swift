//
//  ViewController.swift
//  Kodsnack
//
//  Created by Per Haugsoen on 2014-11-14.
//  Copyright (c) 2014 Haugsoen App Development AB. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController, StatusCheckDelegate {

    @IBOutlet weak var topBar : UIToolbar!
    @IBOutlet weak var podcastLabel: UILabel!
    @IBOutlet weak var onlineStatusLbl: UILabel!
    @IBOutlet weak var pauseButton: UIBarButtonItem!
    @IBOutlet weak var playButton: UIBarButtonItem!
    @IBOutlet weak var container : UIView!
    @IBOutlet weak var titleContainer : UIView!
    
    
    // test
    var globalCounter = 0
    
    var player : AVPlayer
    var jsonData : JSONData!
    
    // används denna?
    var selectedStreamID = "Appsnack"
    
    // initially we start with Appsnack since the anims is that way :)
    var currentPodcast = Pods.Appsnack
    
    var appLogo = UIImageView()
    var kodLogo = UIImageView()
    
    
    var appTitle = UILabel()
    var kodTitle = UILabel()

    
    // custom transition between VCs
    var transitionManager = TransitionManager()
    
    // if the player is logically paused. This is set sep from the .rate property
    var playerPaused : Bool = false
   
    @IBOutlet weak var vol : UIView!
    
    
    required init(coder aDecoder: NSCoder) {
        
        self.player = AVPlayer()
        super.init(coder:aDecoder)
    }
    
    
    
    deinit {
      //  println("DEINIT, removing observer in VC")
        //
        //    player.removeObserver(self, forKeyPath: "status")
    }
    
    
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let volView = MPVolumeView(frame: self.vol.frame)
    vol.backgroundColor = UIColor.clearColor()
    vol.addSubview(volView)
   
    // Set the view bg to same as KodSnack pic bg grey #DCDCDC
    let kodSnackColor = UIColor(red:0.86,green: 0.86,blue: 0.86,alpha: 1)
    view.backgroundColor = kodSnackColor
    
    self.container.backgroundColor = kodSnackColor

    
    // load the logos that can animate
    kodLogo = UIImageView(image: UIImage(named: "kodsnack_large"))
    appLogo = UIImageView(image: UIImage(named: "appsnack_large"))
    self.container.addSubview(appLogo)
    
    // create the Titles that can animate
    appTitle = UILabel(frame: CGRectMake(0, 0, 300, 80))
    kodTitle = UILabel(frame: CGRectMake(0, 0, 300, 80))
    appTitle.text = kAppsnackLabel
    appTitle.textAlignment = NSTextAlignment.Center
    kodTitle.textAlignment = NSTextAlignment.Center
    appTitle.font = UIFont(name: "HelveticaNeue-Light", size: 33.0)
    kodTitle.font = UIFont(name: "HelveticaNeue-Light", size: 33.0)
    kodTitle.text = kKodsnackLabel
    self.titleContainer.addSubview(appTitle)
    
    
    
    
    
    // Listen for entering of bg state
    NSNotificationCenter.defaultCenter().addObserver( self,
        selector: "notifStartListen:",
        name:"notifStartListen",
        object: nil)
    
    tryToConnect()
    
    
    startAnimTimer()
  }
    
    
    // to allow play/pause from iOS control center
    override func remoteControlReceivedWithEvent(event: UIEvent) {
        
        if event.type == UIEventType.RemoteControl {
            
            switch event.subtype {
            case UIEventSubtype.RemoteControlPlay:
                play(self)
            case UIEventSubtype.RemoteControlPause:
               self.pause()
            default:
                break
             }
        }
    }
    
    
//    @IBAction func animateButtonTapped(sender: AnyObject) {
//        animateLogo()
//    }
    
  
    
    func bounceLogo() {
        
        
        let duration = 1.0
        let delay = 0.0
        let options = UIViewAnimationOptions.CurveEaseInOut
        let damping : CGFloat = 0.5 // set damping ration
        let velocity : CGFloat = 1.0 // set initial velocity
        
        
        
        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: velocity, options: options, animations: {
            // any changes entered in this block will be animated

            self.container.transform = CGAffineTransformScale(
                self.container.transform,
                1,
                2)
            
            
            }, completion: { finished in
                // any code entered here will be applied
                // once the animation has completed
                
        })
        
    }
    
    
    // Right now we use the notOnline callback to do the animation. But if we want to
    // animate in a diff way, a timer...
    
    func startAnimTimer() {
           var timer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector:"animateBoth", userInfo: nil, repeats: false)
    }

    
    
    func animateBoth() {
        animateTitle()
        animateLogo()
    }
    
    
    func animateTitle() {
        var views : (frontView: UIView, backView: UIView)
        
        if self.appTitle.superview != nil {
            views = (frontView: self.appTitle, backView: self.kodTitle)
        }
        else {
            views = (frontView: self.kodTitle, backView: self.appTitle)
        }
        
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromRight
        UIView.transitionFromView(views.frontView, toView: views.backView, duration: 1.0, options: transitionOptions, completion: nil)
        
        self.currentPodcast = self.currentPodcast.theOtherValue()
    }
    
    
    func animateLogo() {
    
        var views : (frontView: UIView, backView: UIView)
        
        if self.appLogo.superview != nil {
            views = (frontView: self.appLogo, backView: self.kodLogo)
        }
        else {
            views = (frontView: self.kodLogo, backView: self.appLogo)
        }
    
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromLeft
        UIView.transitionFromView(views.frontView, toView: views.backView, duration: 1.0, options: transitionOptions, completion: nil)

        self.currentPodcast = self.currentPodcast.theOtherValue()
    }

  
    
    // notified that we entered bg mode
  func notifStartListen(notification: NSNotification) {
    println("Notif in VC about start listen")
 //   startListen(pauseMusic: true)
    
  }
  
    
    func notifyUserLocally() {
        
        let locNot = UILocalNotification()
        locNot.fireDate = NSDate(timeIntervalSinceNow: 1)
        locNot.alertBody = "The podcast is now Live"
        locNot.soundName = UILocalNotificationDefaultSoundName
        locNot.timeZone = NSTimeZone.defaultTimeZone()
        UIApplication.sharedApplication().scheduleLocalNotification(locNot)
    }
    
  
  func tryToConnect() {
    
    println("\(NSDate().description) Trying to connect in VC")
    
    jsonData = JSONData()
    jsonData.delegate = self
    jsonData.getStatus(kStreamURL)
    
//    jsonData.getStatus(streamDir[selectedStreamID]!)
  }
  

    
    
    
    
    // Protocol callbacks
    func notOnline() {
        
        println("NotOnLine called in VC")
        animateBoth()
        onlineStatusLbl.text = "Waiting for Pocast to start"
        onlineStatusLbl.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)

        // When not online, play som light bg music :)
        startListen(pauseMusic: true)
        
        
        // try to connect again in kCheckDelay seconds
        var timer = NSTimer.scheduledTimerWithTimeInterval(kCheckDelay, target: self, selector:"tryToConnect", userInfo: nil, repeats: false)
        
        
    }
  
    // Main func for listening.
    func startListen( #pauseMusic: Bool) {
        println("-> StartListen")
        if player.rate > 0.0 {
            print("already playing")
            if pauseMusic {
                println(" PAUSE MUSIC")
                return
            } else {
                println(" LIVE")
                println("####### ERROR, should not happen")
                return
            }
        } else {
            print("Starting to play")
            var error:NSError?
            var urlToCast = NSURL()
            
            if pauseMusic {
                println(" Pause Music")
                urlToCast = NSBundle.mainBundle().URLForResource(kPauseMusicFile, withExtension: "mp3")!
                
                // if the player should be paused, dont start it
                if playerPaused {
                    println("Player paused, wont start for pause music")
                    return
                }
                
            } else {
                println(" Live")
                urlToCast = NSURL(string: jsonData.listen_url)!
           //     onlineStatusLbl.textColor = UIColor.greenColor()
                onlineStatusLbl.text = "O N L I N E"

                // Notify user if App in BG
               //  notifyUserLocally()
                
                
                // show correct signs
                if jsonData.podcast == "Kodsnack" {
                    if self.currentPodcast != Pods.Kodsnack {
                        self.currentPodcast = Pods.Kodsnack
                        animateLogo()
                        animateTitle()
                    }

                    
                    
                } else if jsonData.podcast == "Appsnack" {
                    if self.currentPodcast != Pods.Appsnack {
                        self.currentPodcast = Pods.Appsnack
                        animateLogo()
                        animateTitle()
                    }
                    
                    
                    
                } else {
                    fatalError("Invalid Podcast ID returned in json data")
                }
                
            }
            
            AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
            AVAudioSession.sharedInstance().setActive(true, error: nil)

        
            
            player = AVPlayer(URL: urlToCast)
            
            if pauseMusic {
                player.volume = kDevPauseMusicVolume
            } else {
                player.volume = 1
            }
            
            let options = NSKeyValueObservingOptions.New | NSKeyValueObservingOptions.Old
            player.addObserver(self, forKeyPath: "status", options: options, context: nil)
            
        }
    }
    
  
    
    // Work in progress, does not work and not used
    func fadeIn() {
        
        let params = AVMutableAudioMixInputParameters()
        let timeR = CMTimeRangeMake(CMTimeMake(0,1), CMTimeMake(5, 1))
        params.setVolumeRampFromStartVolume(0.0, toEndVolume: 1.0, timeRange: timeR)
        let allParams = [params]
        
        let mix = AVMutableAudioMix()
        mix.inputParameters = allParams
        player.currentItem.audioMix = mix
    }
  
  
  
  
 
  
    // KVO for player. When ready to play, play and REMOVE observer
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
                UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
                player.play()
                globalCounter++
                fadeIn()
                
                playButton.enabled = false
                println("Listening...")
                
        //        println("removing observer...")
                player.removeObserver(self, forKeyPath: "status")
            }
            
        default:
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
        
        
    }
    

    

  
  @IBAction func pause() {
    println("Pause pressed")
  //  bounceLogo()
    self.dismissViewControllerAnimated(true, completion: nil)
    if player.rate == 0.0 {
      player.play()
      pauseButton.enabled = true
      playButton.enabled = false
      playerPaused = false
       
    } else {
      player.pause()
      pauseButton.enabled = false
      playButton.enabled = true
      playerPaused = true
    }
  }
  
  
  @IBAction func play(sender: AnyObject) {
    println("play pressed")
       if player.rate == 0.0 {
        player.play()
        pauseButton.enabled = true
        playButton.enabled = false
        playerPaused = false
      } else {
        player.pause()
        pauseButton.enabled = false
        playButton.enabled = true
        playerPaused = true
      }
   }
 
    
   
  
  @IBAction func retry() {
    println("Trying to reconnect")
    tryToConnect()
  }
  
    
    @IBAction  func handleTap(recognizer:UITapGestureRecognizer) {
        
        if recognizer.numberOfTouches() == 1 {
            animateBoth()
        }
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let newVC = segue.destinationViewController as ChatVC
        newVC.channelName = self.jsonData.podcast
        
        let toViewController = segue.destinationViewController as UIViewController
        
        self.transitionManager = TransitionManager()
        toViewController.transitioningDelegate = self.transitionManager
    }
}

















