//
//  AppDelegate.swift
//  SlackClone
//
//  Created by Ivan Sliepov on 12.09.2020.
//  Copyright © 2020 Ivan Sliepov. All rights reserved.
//

import Cocoa
import Parse

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let config = ParseClientConfiguration {
            (configThing: ParseMutableClientConfiguration) in
            configThing.applicationId = "slackClone-2"
            configThing.server = "http://slackclone-2.herokuapp.com/parse"
        }
        Parse.initialize(with: config)
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

