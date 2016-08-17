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
    
    
    
    @IBOutlet weak var quiteButton: NSButton!
    @IBOutlet weak var refreshButton: NSButton!
    @IBOutlet weak var header: NSTableHeaderView!
    @IBOutlet weak var table: NSOutlineView!
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var dateTexField: NSTextField!
    @IBOutlet weak var typeTextField: NSTextField!
    let source = DataSource()
    let board = NSPasteboard.generalPasteboard()
    let applicationMenu = NSMenu()
    let dateFormatter = NSDateFormatter()
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
        self.view.layer?.backgroundColor = NSColor(calibratedRed: 0.949, green: 0.949, blue: 0.949, alpha: 1.00).CGColor
        self.table.backgroundColor =  NSColor(calibratedRed: 0.949, green: 0.949, blue: 0.949, alpha: 1.00)

        self.textField.stringValue = ""
        
        
        self.refreshButton.bezelStyle = NSBezelStyle.SmallSquareBezelStyle
        self.quiteButton.bezelStyle = NSBezelStyle.SmallSquareBezelStyle
        self.quiteButton.wantsLayer = true;
        self.quiteButton.layer?.backgroundColor = NSColor(calibratedRed: 0.922, green: 0.922, blue: 0.922, alpha: 1.00).CGColor
        
        table.setDataSource(source)
        table.setDelegate(self)
        table.indentationPerLevel = CGFloat(20.0)
        table.selectedRow
        table.setDraggingSourceOperationMask(NSDragOperation.Copy, forLocal: false)
        table.allowsMultipleSelection = true 

        self.dateFormatter.dateStyle = .MediumStyle
        self.dateFormatter.timeStyle = .NoStyle
        self.dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        print("The header is\(self.table.tableColumnWithIdentifier("FileColumn")?.headerCell.title)")
        
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
//    func tableView(tableView: NSTableView, willDisplayCell cell: AnyObject, forTableColumn tableColumn: NSTableColumn?, row: Int) {
//        
//        if let currentCell  = cell as NSOutlineVie
//        if tableView.selectedRowIndexes.containsIndex(row){
//            cell.backgroundColor =  NSColor.blueColor()
//        }else{
//            cell.backgroundColor = NSColor.whiteColor()
//        }
//        cell.drawsBackground = true;
//    }
    
}
