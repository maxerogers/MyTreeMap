//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"
let fileManager = NSFileManager()
//var documentsPath = NSSearchPathForDirectoriesInDomains(.UserDirectory,
//                                                        .AllDomainsMask,
//                                                        true)
let path = "/Users/maxrogers/dev/MyTreeMap/MyTreeMap/ExplorativeTree"
let contents = try fileManager.contentsOfDirectoryAtPath(path)
for document in contents {
    print(document)
    do {
        let attrs = try fileManager.attributesOfItemAtPath("/Users/maxrogers/dev/MyTreeMap/MyTreeMap/ExplorativeTree")

        print(attrs["NSFileSize"]!)
    }
    catch { print(error) }
}
