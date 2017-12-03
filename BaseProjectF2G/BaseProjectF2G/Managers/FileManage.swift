//
//  FileManage.swift
//  BaseSwift
//
//  Created by Quynh Nguyen on 6/18/17.
//  Copyright © 2017 Quynh Nguyen. All rights reserved.
//

import Foundation


class FileManage: NSObject {
    private static func ensureFolder(_ path: String) {
        var isDir: ObjCBool = false
        if !FileManager.default.fileExists(atPath: path, isDirectory: &isDir) || !isDir.boolValue {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch  {
                
            }
        }
    }
    
    static func document() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    static func cache() -> String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    }
    
    static func library() -> String {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
    }
    
    static func folderSize(folder: String) -> UInt {
        let filesArray:[String] = try! FileManager.default.subpathsOfDirectory(atPath: folder)
        var fileSize:UInt = 0
        
        for fileName in filesArray{
            let filePath = (folder as NSString).appendingPathComponent(fileName)
            let fileDictionary:NSDictionary = try! FileManager.default.attributesOfItem(atPath: filePath) as NSDictionary
            fileSize += UInt(fileDictionary.fileSize())
        }
        
        return fileSize
    }
    
    static func deleteContent(ofFolder: String) {
        let filesArray:[String] = try! FileManager.default.subpathsOfDirectory(atPath: ofFolder)
        for fileName in filesArray{
            let filePath = (ofFolder as NSString).appendingPathComponent(fileName)
            try? FileManager.default.removeItem(atPath: filePath)
        }
    }
    
}
