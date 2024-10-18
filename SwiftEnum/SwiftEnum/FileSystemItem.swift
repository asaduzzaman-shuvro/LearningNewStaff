//
//  FileSystemItem.swift
//  SwiftEnum
//
//  Created by Asaduzzaman Shuvro on 18/10/24.
//

import Foundation

enum FileSystemItem {
    case file(name: String)
    case folder(name: String, items: [FileSystemItem])
    indirect case alias(name: String, to: FileSystemItem)
}

class FileSystem {
    
    init() {
        let imageFile = FileSystemItem.file(name: "image.png")
        let textFile = FileSystemItem.file(name: "text.txt")

        let documentFolder = FileSystemItem.folder(name: "Documents", items: [imageFile, textFile])
        let profileImageAlias = FileSystemItem.alias(name: "ProfileImage", to: imageFile)
        let desktopFolder = FileSystemItem.folder(name: "Desktop", items: [documentFolder,profileImageAlias])
     
        print(countItems(in: desktopFolder))
    }
    
    private func countItems(in item: FileSystemItem) -> Int {
        switch item {
        case .file: return 1
        case .folder(name: _, items: let items):
            return items.map(countItems(in:)).reduce(0, +)
        case .alias(_, let to):
            return countItems(in: to)
        }
    }
}
