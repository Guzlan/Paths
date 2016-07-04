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
        return 1
    }
    @objc func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        return true
    }
    @objc func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        return true
    }
    @objc func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
        return true
    }

}