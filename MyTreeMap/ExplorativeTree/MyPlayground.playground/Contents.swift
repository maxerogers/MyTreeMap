//: Playground - noun: a place where people can play

import Cocoa

struct File : Hashable {
    let size: Int
    let path: String
    let name: String
    init(name: String, path: String, size: Int) {
        self.name = name
        self.path = path
        self.size = size
    }
    var hashValue: Int { get { return "\(path)/\(name)".hashValue } }
}

func ==(lhs:File, rhs:File) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

class Node<T: Hashable> : Hashable {
    var parent: Node?
    var children: [Node] = []
    var value: T
    init(_ value: T) {
        self.value = value
    }
    var hashValue: Int { get { return value.hashValue } }
}

func ==<T>(lhs:Node<T>, rhs:Node<T>) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

var str = "Hello, playground"

let fileManager = NSFileManager()
//var documentsPath = NSSearchPathForDirectoriesInDomains(.UserDirectory,
//                                                        .AllDomainsMask,
//                                                        true)
let path = "/Users/maxrogers/dev/MyTreeMap/MyTreeMap/ExplorativeTree"
let contents = try fileManager.contentsOfDirectoryAtPath(path)

for document in contents {
    do {
        let attrs = try fileManager.attributesOfItemAtPath("\(path)/\(document)")
        print("\(document) : \(attrs["NSFileType"]!) : \(attrs["NSFileSize"]!) bytes")
        
    }
    catch { print(error) }
}
