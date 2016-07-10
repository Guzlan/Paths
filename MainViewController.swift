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
    let board = NSPasteboard.generalPasteboard()
    
    @IBAction func clipboardCopy(sender: NSButton) {
        board.clearContents()
        board.setString(textField.stringValue, forType: NSPasteboardTypeString)
        print("Copied successfully")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.textField.stringValue = ""
        table.setDataSource(source)
        table.setDelegate(self)
        table.indentationPerLevel = CGFloat(20.0)
        table.selectedRow
        // userAmr?.setChildren()
        //userAmr?.printChildren()
        //user!.printChildren()
       // rootItem.printChildren()
        //view.addSubview(lalala
        // Do view setup here.
    }
    func outlineView(outlineView: NSOutlineView, shouldSelectItem item: AnyObject) -> Bool {
        let filetItem = item as? FileSystemItem
        self.textField.stringValue = (filetItem?.getFullPath())!
        return true
    }
//    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
//        let view = NSTableCellView?()
//        
//        return view
//    }
    
}
