//
//  BrowserView.swift
//  Paths
//
//  Created by Amr Guzlan on 2016-06-30.
//  Copyright © 2016 Amro Gazlan. All rights reserved.
//

import Cocoa

class BrowserView: NSView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        print("I got called")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
