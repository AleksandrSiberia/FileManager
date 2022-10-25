//
//  FileManagerServiceProtocol.swift
//  FileManager
//
//  Created by Александр Хмыров on 21.10.2022.
//

import Foundation
import UIKit

protocol FileManagerServiceProtocol {

    func contentsOfDirectory(nameNewDirectory: String, completionURL: (URL, String) -> Void) -> [ModelFileManager]
    func createDirectory(nameFolder: String, completion: (String?) -> Void)
    func createFile(image: UIImage)
    func removeContent(url: String, completion: (String?) -> Void)
    func openFoto(nameFoto: String, completion: @escaping (String) -> Void)
}
