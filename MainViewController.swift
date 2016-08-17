//
//  MainViewController.swift
//  Paths
//
//  Created by Amro Gazlan on 2016-06-30.
//  Copyright © 2016 Amro Gazlan. All rights reserved.
//

import Cocoa
//import EonilFileSystemEvents

class MainViewController: NSViewController, NSOutlineViewDelegate, NSTableViewDelegate {
    
    
    
    @IBOutlet weak var quiteButton: NSButton!
    @IBOutlet weak var refreshButton: NSButton!
    @IBOutlet weak var table: NSOutlineView! // the table that displays the file system heirarchy
    @IBOutlet weak var textField: NSTextField! // the textfield that displays the path of a file item
    @IBOutlet weak var dateTexField: NSTextField! // text field that displays the date of a file item
    @IBOutlet weak var typeTextField: NSTextField! // text field that displays the type of a file item
    
    
    let source = DataSource() // an instance of DataSource class
    let board = NSPasteboard.generalPasteboard() // the pasteboard that copies the path of file item to clipboard
    let dateFormatter = NSDateFormatter() // used to formate displayed date of a file item
    
    // function that copies the path to clipboard when the copy button is clicked
    @IBAction func clipboardCopy(sender: NSButton) {
        board.clearContents() // clear previous items on clipboard
        board.setString(textField.stringValue, forType: NSPasteboardTypeString) // copies the text displayed in textField to clipboard
    }
    
    @IBAction func refresh(sender: NSButton) {
        iterativeExpansion()
    }
    
    
    // terminates the application
    @IBAction func quiteButton(sender: NSButton) {
        NSApplication.sharedApplication().terminate(sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sitting the background color of the table
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(calibratedRed: 0.949, green: 0.949, blue: 0.949, alpha: 1.00).CGColor
        self.table.backgroundColor =  NSColor(calibratedRed: 0.949, green: 0.949, blue: 0.949, alpha: 1.00)
        // giving empty string to the path textField
        self.textField.stringValue = ""
        
        // setting shape of the refresh and quite button
        self.refreshButton.bezelStyle = NSBezelStyle.SmallSquareBezelStyle
        self.quiteButton.bezelStyle = NSBezelStyle.SmallSquareBezelStyle
        
        table.setDataSource(source) // setting the data source for the table
        table.setDelegate(self) // setting the OutlineViewDelegate as myself
        table.indentationPerLevel = CGFloat(20.0) // setting the indentaton distance
        table.setDraggingSourceOperationMask(NSDragOperation.Copy, forLocal: false) // allow dragging and copying items from the table
        table.allowsMultipleSelection = true  // allows selecting multiple file items for drag and drop operation
        
        // formating the way the date is displayed
        self.dateFormatter.dateStyle = .MediumStyle
        self.dateFormatter.timeStyle = .NoStyle
        self.dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        
    }
    func iterativeExpansion()->(){
        // goes through displayed rows in the table and
        // records the indixies of rows that are expanded
        var indexies = [Int]()
        for index in 0..<(self.table.numberOfRows) {
            if table.isItemExpanded(table.itemAtRow(index)){
                indexies.append(index)
            }
        }
        self.table.reloadData() // reloads the data of the table
        
        var newIndex = 0
        for index in indexies{
            // because reloadData closes all previously expanded items
            // we will need to re expand them.
            self.table.expandItem(self.table?.itemAtRow(index))
            // record the last expanded item
            newIndex = index
        }
        // scroll to the last expanded item
        self.table.scrollRowToVisible(newIndex)
    }
    // setting the textField string to the path of a selected file item
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
