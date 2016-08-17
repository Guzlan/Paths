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
    var eventMonitor: EventMonitor?
    
    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
   
        
        // setting the button image and the action is calls
        if let button = statusItem.button{
            button.image = barIconImage
            button.action = #selector(AppDelegate.togglePopover(_:))
        }
        // set the popover view controller as the MainViewController which is the main one for our application
        popover.contentViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        popover.animates = false;
        eventMonitor = EventMonitor(mask: [.LeftMouseDownMask , .RightMouseDownMask]) { [unowned self] event in
            if self.popover.shown {
                self.closePopover(event!)
            }
        }
        eventMonitor?.start()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    // this will show the pop view
    func openPopover(sender:AnyObject){
        if let button = statusItem.button{
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
            eventMonitor?.start()
        }
    }
    // this will hide or close the pop view
    func closePopover(sender:AnyObject){
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    func togglePopover(sender:AnyObject){
        if popover.shown{
            closePopover(sender)
        }else{
            openPopover(sender)
        }
    }
//    func initializeMenuItems() {
//        self.applicationMenu.addItem(NSMenuItem(title: "Quit", action: Selector(NSApplication.sharedApplication().terminate(self)), keyEquivalent: "q"))
//    }

}

