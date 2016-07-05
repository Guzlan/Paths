//
//  DataSource.swift
//  Paths
//
//  Created by Amr Guzlan on 2016-07-03.
//  Copyright © 2016 Amro Gazlan. All rights reserved.
//

import Foundation
import AppKit


class DataSource: NSObject, NSOutlineViewDataSource{
    @objc func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if let filetItem = item as? FileSystemItem{
            return filetItem.numberOFChildren()
        }else {
            return 1
        }
    }
    @objc func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        if let filetItem = item as? FileSystemItem{
            return (filetItem.numberOFChildren() != -1) ? true : false
        }else {
            return true
        }
    }
    @objc func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        if let filetItem = item as? FileSystemItem{
            return filetItem.getChildAtIndex(index)!
        }else {
            return FileSystemItem.getRootItem()
        }
    }
    @objc func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
        if let filetItem = item as? FileSystemItem{
            return filetItem.getRelativePath()
        }else {
            return "/"
        }
    }

}