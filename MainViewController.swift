//
//  MainViewController.swift
//  Paths
//
//  Created by Amr Guzlan on 2016-06-30.
//  Copyright © 2016 Amro Gazlan. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController, NSOutlineViewDelegate {
    
    
    @IBOutlet weak var table: NSOutlineView!
    @IBOutlet weak var textField: NSTextField!
    
    let source = DataSource()
    
    @IBAction func clipboardCopy(sender: NSButton) {
        
        print("Hello")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        table.setDataSource(source)
        // userAmr?.setChildren()
        //userAmr?.printChildren()
        //user!.printChildren()
       // rootItem.printChildren()
        //view.addSubview(lalala
        // Do view setup here.
    }
//    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
//        let view = NSTableCellView?()
//        
//        return view
//    }
    
}
