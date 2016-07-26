//
//  File.swift
//  MyTreeMap
//
//  Created by Max Rogers on 7/26/16.
//  Copyright © 2016 max rogers. All rights reserved.
//

import Foundation

struct File {
    var fileName:String
    var size:Int
    var path: String
    init(fileName: String, size: Int, path: String) {
        self.fileName = fileName
        self.size = size
        self.path = path
    }
}