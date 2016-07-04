//
//  AppDelegate.swift
//  Paths
//
//  Created by Amr Guzlan on 2016-06-30.
//  Copyright © 2016 Amro Gazlan. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  //  This creates a Status Item — aka application icon — in the menu bar with a fixed length that the user will see and use.
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    let popover = NSPopover()
    // get the image of icon that the user will click 
    let barIconImage = NSImage(named: "StatusBarButtonImage")
    
    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // setting the button image and the action is calls 
        if let button = statusItem.button{
            button.image = barIconImage
            button.action = #selector(AppDelegate.togglePopover(_:))
        }
        // set the popover view controller as the MainViewController which is the main one for our application
        popover.contentViewController = MainViewController(nibName: "MainViewController", bundle: nil)

    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    // this will show the pop view
    func openPopover(sender:AnyObject){
        if let button = statusItem.button{
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
    }
    // this will hide or close the pop view
    func closePopover(sender:AnyObject){
        popover.performClose(sender)
    }
    func togglePopover(sender:AnyObject){
        if popover.shown{
            closePopover(sender)
        }else{
            openPopover(sender)
        }
    }
}

