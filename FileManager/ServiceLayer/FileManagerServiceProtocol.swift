//
//  FileManagerServiceProtocol.swift
//  FileManager
//
//  Created by Александр Хмыров on 21.10.2022.
//

import Foundation
import UIKit

protocol FileManagerServiceProtocol {

    func contentsOfDirectory(nameNewDirectory: String, completionURL: @escaping (URL, String) -> Void) -> [ModelFileManager]
    func createDirectory(nameFolder: String, completion: @escaping (String?) -> Void)
    func createFile(image: UIImage)
    func removeContent(url: String, completion: @escaping (String?) -> Void)
    func openFoto(nameFoto: String, completion: @escaping (UIImage) -> Void)
}
