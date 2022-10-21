//
//  ModelFileManager.swift
//  FileManager
//
//  Created by Александр Хмыров on 21.10.2022.
//

import Foundation


enum TypeModelFileManager {
    case folder
    case file
}

struct ModelFileManager {
    var type: TypeModelFileManager
    var name: String
    var url: String
}
