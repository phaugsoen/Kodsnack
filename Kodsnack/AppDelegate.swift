//
//  AppDelegate.swift
//  Kodsnack
//
//  Created by Per Haugsoen on 2014-11-14.
//  Copyright (c) 2014 Haugsoen App Development AB. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
    
    // register for local notifications (permission)
    let notPermSett = UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert, categories: nil)
    
    application.registerUserNotificationSettings(notPermSett)
    
    
  //  let orange = UIColor.orangeColor()
    
    
   // listFonts()
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    // Debug printing
    println("resign active ")
    
    NSNotificationCenter.defaultCenter().postNotificationName("notifStartListen", object: self, userInfo: nil)
    
  //  let mainVC = window?.rootViewController as ViewController
  //  mainVC.dummy()
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     // Debug printing
    
    // setup local notifications
    
/*
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    localNotification.alertBody = @"new Blog Posted at iOScreator.com";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
  */
    
    println("did enter background")
 /*
    let locNot = UILocalNotification()
    locNot.fireDate = NSDate(timeIntervalSinceNow: 10)
    locNot.alertBody = "The podcast is now Live"
    locNot.soundName = UILocalNotificationDefaultSoundName
    locNot.timeZone = NSTimeZone.defaultTimeZone()
    UIApplication.sharedApplication().scheduleLocalNotification(locNot)
   */
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    // Debug printing
    println("will enter foreground")
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // Debug printing
    println("did become Active")
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        println("will terminate")
  }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        println("Got Notification about Live broadcast")
    }
    

    
    
    

}

