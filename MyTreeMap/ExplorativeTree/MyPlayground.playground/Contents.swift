//: Playground - noun: a place where people can play

import Cocoa

struct File: Hashable {
    let size: Int
    let path: String
    let name: String
    let type: String
    init(name: String, path: String, size: Int, type: String) {
        self.name = name
        self.path = path
        self.size = size
        self.type = type
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
    init(value: T) {
        self.value = value
    }
    var hashValue: Int { get { return value.hashValue } }
}

func ==<T>(lhs:Node<T>, rhs:Node<T>) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

//struct Node: Hashable {
//    var file: File
//    var hashValue: Int { get { return self.file.name.hashValue } }
//    init(file: File) {
//        self.file = file
//    }
//}
//
//func ==(lhs:Node, rhs:Node) -> Bool {
//    return lhs.hashValue == rhs.hashValue
//}
//
//enum Tree<Element: Hashable> {
//    case Empty
//    case Node(Element, [Tree<Element>])
//}

func DFS_docs(path: String, current: Node<File>?) {
    if let _ = current {
        if current?.value.type != "NSFileTypeDirectory" {
            return
        }
    }
    
    let fileManager = FileManager()
    do {
        let contents = try fileManager.contentsOfDirectory(atPath: path)
        for document in contents {
            let newPath = "\(path)/\(document)"
            let attrs = try fileManager.attributesOfItem(atPath: newPath) as NSDictionary

            print("\(document) : \(attrs.fileType()) : \(attrs.fileSize()) bytes")
            
            let file = File(name: document,
                            path: path,
                            size: Int(attrs.fileSize()),
                            type: attrs.fileType()!)
            let node = Node<File>(value: file)
            current?.children.append(node)
            DFS_docs(path: newPath, current: node)
        }
    }
    catch { print(error) }
    
    return
}

func DFS_size(node: Node<File>) -> Int {
    var result = node.value.size
    for child in node.children {
        result += DFS_size(node: child)
    }
    return result
}

let fileManager = FileManager()
//var documentsPath = NSSearchPathForDirectoriesInDomains(.UserDirectory,
//                                                        .AllDomainsMask,
//                                                        true)
//let path = "/Users/maxrogers/dev/MyTreeMap/MyTreeMap/ExplorativeTree"
let path = "/Users/maxrogers/dev/MyTreeMap/MyTreeMap"
let root = Node(value: File(name: "", path: "", size: 0,
                            type: "NSFileTypeDirectory"))
DFS_docs(path: path, current: root)
print("\(DFS_size(node: root)) bytes")
