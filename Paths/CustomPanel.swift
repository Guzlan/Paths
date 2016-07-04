//
//  CustomPanel.swift
//  Paths
//
//  Created by Amr Guzlan on 2016-07-02.
//  Copyright © 2016 Amro Gazlan. All rights reserved.
//

import Cocoa

class CustomPanel: NSOpenPanel {
    
    var myFrame :NSSize?
//    override func center() {
//        self.setContentSize(myFrame!)
//    }
//    
    func setMyFrame (theFrameIwant :NSSize){
        self.myFrame = theFrameIwant
    }

}
