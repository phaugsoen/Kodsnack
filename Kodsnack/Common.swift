//
//  Common.swift
//  kodsnack
//
//  Created by Per Haugsoen on 27/11/14.
//  Copyright (c) 2014 Haugsoen App Development AB. All rights reserved.
//

import Foundation
import UIKit



// URL to Appsnack chat
var kChatURLPath = "http://kiwiirc.com/client/irc.freenode.net/"

// How often (secs) the icecast server is checked
let kCheckDelay = 10.0


let kKodsnackLabel = "Kodsnack Live"
let kAppsnackLabel = "Appsnack Live"


// The url to connect, (appsnack is the same host)
let kStreamURL = "http://live.kodsnack.se/feed.json"


// Should be .mp3 and in the bundle
let kPauseMusicFile = "bensound-theelevatorbossanova"

//  When dev, play pause music at a lower volume (1=normal)
let kDevPauseMusicVolume : Float = 0.3


// The grey color of the Kodsnack logo
let kKodsnackBgColor = UIColor(red:0.89,green: 0.89,blue: 0.89,alpha: 1)


// for testing
let streamDir = ["Kodsnack" : "http://live.kodsnack.se/feed.json",
    "Appsnack" : "http://live.appsnack.se/feed.json",
    "Slashat"  : "asdasd",
    "Apple"    : "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8",
    "P4STH"       : "http://sverigesradio.se/topsy/direkt/701-hi-mp3.m3u"]




enum Pods : Int {
    case Kodsnack = 1
    case Appsnack = 2
    
    func theOtherValue() -> Pods {
        switch self {
        case .Appsnack:
            return Pods.Kodsnack
        case .Kodsnack:
            return Pods.Appsnack
        }
    }
}



// List available fonts on device
func listFonts() {
    let fams = UIFont.familyNames()
    for aFam in fams {
        println("\(aFam.description)")
        for aName in UIFont.fontNamesForFamilyName(aFam.description) {
            println("name:\(aName)")
        }
    } 
}