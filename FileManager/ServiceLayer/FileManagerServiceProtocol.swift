//
//  FileManagerServiceProtocol.swift
//  FileManager
//
//  Created by Александр Хмыров on 21.10.2022.
//

import Foundation


protocol FileManagerServiceProtocol {

    func contentsOfDirectory() -> [ModelFileManager]
    func createDirectory()
    func createFile()
    func removeContent()
}
