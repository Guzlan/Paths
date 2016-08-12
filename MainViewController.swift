//
//  MainViewController.swift
//  Paths
//
//  Created by Amr Guzlan on 2016-06-30.
//  Copyright © 2016 Amro Gazlan. All rights reserved.
//

import Cocoa
//import EonilFileSystemEvents

class MainViewController: NSViewController, NSOutlineViewDelegate, NSTableViewDelegate {
    
    
    
    @IBOutlet weak var clipView: NSClipView!
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var table: NSOutlineView!
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var dateTexField: NSTextField!
    @IBOutlet weak var typeTextField: NSTextField!
    let source = DataSource()
    let board = NSPasteboard.generalPasteboard()
    let applicationMenu = NSMenu()
    let dateFormatter = NSDateFormatter()
    let testString = "MEOW"
    //var	monitor	=	nil as FileSystemEventMonitor?
    //var	queue	=	dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
    @IBAction func clipboardCopy(sender: NSButton) {
        board.clearContents()
        board.setString(textField.stringValue, forType: NSPasteboardTypeString)
        
    }
    
    @IBAction func refresh(sender: NSButton) {
        //table.reloadItem(table.itemAtRow(6) as? FileSystemItem)
        recursiveExpansion(0)
        
    }
    func recursiveExpansion(index: Int)->(){
       // let currentRow = self.table.selectedRow
        
        var indexies = [Int]()
        
        for index in 0..<(self.table.numberOfRows) {
            if table.isItemExpanded(table.itemAtRow(index)){
                indexies.append(index)
            }
        }
        self.table.reloadData()
        var newIndex = 0
        for index in indexies{
            self.table.expandItem(self.table?.itemAtRow(index))
            newIndex = index
        }
        self.table.scrollRowToVisible(newIndex)
    }
    @IBAction func quiteButton(sender: NSButton) {
        NSApplication.sharedApplication().terminate(sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(calibratedRed: 0.235, green: 0.498, blue: 0.616, alpha: 1.00).CGColor

        self.textField.stringValue = ""
//        scrollView.wantsLayer = true
//        scrollView.layer?.backgroundColor =
//            NSColor(calibratedRed: 0.235, green: 0.498, blue: 0.616, alpha: 1.00).CGColor
//        scrollView.backgroundColor = NSColor(calibratedRed: 0.235, green: 0.498, blue: 0.616, alpha: 1.00)
        
        table.setDataSource(source)
        table.setDelegate(self)
        table.indentationPerLevel = CGFloat(20.0)
        table.selectedRow
        table.setDraggingSourceOperationMask(NSDragOperation.Copy, forLocal: false)
                clipView.wantsLayer = true
               clipView.layer?.backgroundColor =
                    NSColor(calibratedRed: 0.235, green: 0.498, blue: 0.616, alpha: 1.00).CGColor
                clipView.backgroundColor = NSColor(calibratedRed: 0.235, green: 0.498, blue: 0.616, alpha: 1.00)
        
        self.dateFormatter.dateStyle = .MediumStyle
        self.dateFormatter.timeStyle = .NoStyle
        self.dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        
    }
    func outlineView(outlineView: NSOutlineView, shouldSelectItem item: AnyObject) -> Bool {
        let filetItem = item as? FileSystemItem
        self.textField.stringValue = (filetItem?.getFullPath())!
        self.dateTexField.stringValue = dateFormatter.stringFromDate((filetItem?.getDate())!)
        if let fileItemExtension  = NSURL(fileURLWithPath: (filetItem?.getFullPath())!).pathExtension where !fileItemExtension.isEmpty{
            self.typeTextField.stringValue = fileItemExtension
        }else {
            self.typeTextField.stringValue = "Folder/No extension"
        }
        return true
    }
    
}
