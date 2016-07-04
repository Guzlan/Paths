//
//  MainViewController.swift
//  Paths
//
//  Created by Amr Guzlan on 2016-06-30.
//  Copyright © 2016 Amro Gazlan. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    

    @IBOutlet weak var textField: NSTextField!
    @IBAction func clipboardCopy(sender: NSButton) {
        
        print("Hello")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        // userAmr?.setChildren()
        //userAmr?.printChildren()
        //user!.printChildren()
       // rootItem.printChildren()
        //view.addSubview(lalala
        // Do view setup here.
    }
    
}
