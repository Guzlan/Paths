//
//  DataSource.swift
//  Paths
//
//  Created by Amr Guzlan on 2016-07-03.
//  Copyright © 2016 Amro Gazlan. All rights reserved.
//

import Foundation
import AppKit
import CoreServices


class DataSource: NSObject, NSOutlineViewDataSource{
    
    let rootFile: FileSystemItem?
    let dateFormatter = NSDateFormatter()
    //let pb: NSPasteboard?
    override init(){
        self.pb = NSPasteboard(name: NSDragPboard)
        self.rootFile = FileSystemItem.getRootItem()
        self.rootFile?.setChildren()
        self.dateFormatter.dateStyle = .MediumStyle
        self.dateFormatter.timeStyle = .NoStyle
        self.dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        super.init()
    }
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if item != nil {
            let filetItem = item as? FileSystemItem
            return filetItem!.numberOFChildren()
        }else {
            return 1
        }
    }
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        let filetItem = item as? FileSystemItem
        filetItem?.setChildren()
        let fileItemTruth = (filetItem!.numberOFChildren() != -1) ? true : false
        return fileItemTruth
        
    }
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        if item != nil{
            let filetItem = item as? FileSystemItem
            return filetItem!.getChildAtIndex(index)!
        }else {
            return self.rootFile!
        }
    }
    
        func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
            if item != nil {
                    let filetItem = item as? FileSystemItem
                    if tableColumn?.identifier == "FileColumn"{
                        return (filetItem?.getRelativePath() == "/") ? "root" : filetItem?.getRelativePath()
                        
                    }
                    else {
                        return dateFormatter.stringFromDate((filetItem?.getDate())!)
                    }
                }else {
                    return "not set"
                }
        }
    
    let pb: NSPasteboard?
    func outlineView(outlineView: NSOutlineView, writeItems items: [AnyObject], toPasteboard pasteboard: NSPasteboard) -> Bool {
        var array = [String]()
        self.pb?.declareTypes([NSFilesPromisePboardType], owner: self)
        for item in items {
            if let fileItem = item as? FileSystemItem {
                let fileURL = fileItem.getFullPath()!
                array.append(fileURL)
                print (array);
            }
            else {
                return false
            }
        }
        self.pb?.setPropertyList(array, forType: NSFilenamesPboardType)
        return true
    }

}