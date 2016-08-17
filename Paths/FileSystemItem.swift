//
//  FileSystemItem.swift
//  Paths
//
//  Created by Amr Guzlan on 2016-07-03.
//  Copyright © 2016 Amro Gazlan. All rights reserved.
//

import Cocoa

class FileSystemItem: NSObject {
    
    
    var relativePath : String? // path of the current system file item
    var parentNode : FileSystemItem? // the parent item of this sytem file item (itself is an item)
    var children : [FileSystemItem]? // children of the current system file item (themselves are children)
    
    var date = NSDate() // date of a file item
    var type = String() // type of a file item
    
    //type variables that hold the root item and the leaf items/nodes
    static var rootItem:FileSystemItem?
    static var leafNodes = [FileSystemItem]()
    
    //initializer of the FielSystemItem object, takes the path and parent
    init ( path: String, parentItem item: FileSystemItem?){
        self.relativePath = NSURL(fileURLWithPath: path).lastPathComponent
        self.parentNode = item
    }
    
    // type methods that sets or returns the root item of the file system if it does not exist
    static func getRootItem() -> FileSystemItem{
        if rootItem == nil {
            rootItem = FileSystemItem(path: "/", parentItem: nil)
        }
        return rootItem!
    }
    
    
    // Creates, caches, and returns the array of children
    // Loads children incrementally
    func setChildren (){
            let fileManager = NSFileManager.defaultManager()  // get a file manager instance to use for fetching paths
            let fullPath = self.getFullPath() // get the full path of file item
        do {
            let attributes = try fileManager.attributesOfItemAtPath(fullPath!)
            self.date = attributes[NSFileCreationDate] as! NSDate // getting the creation date of the file
            if let currentFileItemType = attributes[NSFileType] as! String? { // getting the file type attribute
                self.type = currentFileItemType
            }else {
                self.type = "folder"
            }
            
            
        }
        catch{
            
        }
            var isDirectory = false, valid = false
            
            if fullPath != nil{
                valid = fileManager.fileExistsAtPath(fullPath!)
                
                if valid && (fileManager.contentsAtPath(fullPath!) == nil){
                    
                    isDirectory = true
                }
                
            }
            
            if isDirectory && valid {
                var array = [String]()
                var array2 = [NSURL]()
                do {
                    array2.appendContentsOf(try fileManager.contentsOfDirectoryAtURL(NSURL(fileURLWithPath: fullPath!), includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions.SkipsHiddenFiles))
                    array = array2.map { String($0.path!)}
                    
                    self.children = [FileSystemItem]()
                }catch{
                }
                
                for child in array {
                    let newChild = FileSystemItem(path: child, parentItem: self)
                    self.children!.append(newChild)
                }
            }else {
                self.children = FileSystemItem.leafNodes
            }
    }
    
    func getRelativePath()-> String? {
        return self.relativePath
    }
    
    
    func getChildAtIndex (index :Int)->FileSystemItem? {
        if let childrenOfSelf = self.children where index < childrenOfSelf.count && index >= 0 { // incase of passing illegal index.
                    return self.children![index]
        }else {
            return nil
        }
    }
    
    
    
    func numberOFChildren()->Int{
        if self.children != nil{
            // you can use them as unwrapped because they were checked for safety in the previous if statement..
            return (self.children! == FileSystemItem.leafNodes) ? -1 : (self.children!.count)
        }
        else {
            return -1
        }
    }
    
    
    func getFullPath ()->String? {
        if self.relativePath != nil {
            if self.parentNode == nil {
                return relativePath
            }else {
                // recurse up the hierarchy, prepending each parent’s path
                return parentNode?.getFullPath()?.stringByAppendingString(relativePath!+"/")
            }
        }
        else {
            return nil
        }
        
    }
    func getDate () ->NSDate{
            return self.date
    }
}
