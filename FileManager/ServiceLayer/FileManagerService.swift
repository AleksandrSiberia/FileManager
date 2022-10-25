//
//  FileManagerService.swift
//  FileManager
//
//  Created by Александр Хмыров on 21.10.2022.
//

import Foundation
import UIKit



class FileManagerService: FileManagerServiceProtocol {

    

    var urlDocumentDirectoryString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

    var urlDocumentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]




    func openFoto(nameFoto: String, completion: @escaping (UIImage) -> Void) {

        let urlString = String(describing: urlDocumentDirectoryURL) + nameFoto

        guard let url = URL(string: urlString) else {

            return
        }
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            completion(image!)
        }
        catch  {
            print(error.localizedDescription)
        }

    }


    func contentsOfDirectory(nameNewDirectory: String, completionURL: @escaping (URL, String) -> Void)  -> [ModelFileManager] {


        if nameNewDirectory != "Documents" {

            let urlDocumentDirectoryURLNew = URL(string: String(describing: urlDocumentDirectoryURL) + "\(nameNewDirectory)")!
            self.urlDocumentDirectoryURL = urlDocumentDirectoryURLNew

            self.urlDocumentDirectoryString += "/" + nameNewDirectory


        }
        completionURL(self.urlDocumentDirectoryURL, self.urlDocumentDirectoryString)

        var foldersNames: [String] = []

        var contentsNames: [String] = []

        var modelFileManager: [ModelFileManager] = []


        let folderURL =  try? FileManager.default.contentsOfDirectory(at: urlDocumentDirectoryURL, includingPropertiesForKeys: [], options: []).filter({ URL in
            URL.hasDirectoryPath
        })

        do {
            var fName: [String] = []
            let _: [()] = try FileManager.default.contentsOfDirectory(atPath: urlDocumentDirectoryString).map({ content in
                if let folderURL {

                    for url in folderURL {
                        if url == URL(string: String(describing: urlDocumentDirectoryURL).appending("\(content)/"))
                        {
                            fName.append(content)
                        }
                    }
                }
            })
            foldersNames = fName
        }
        catch {
            print(error.localizedDescription)
        }
        do {
            let arrayNamesContent = try FileManager.default.contentsOfDirectory(atPath: urlDocumentDirectoryString)
            contentsNames = arrayNamesContent
        }
        catch {
            print(error.localizedDescription)
        }


        for folder in foldersNames {
            contentsNames.removeAll { string in
                string == folder
            }
        }


        for name in foldersNames {
            modelFileManager.append(ModelFileManager(type: .folder, name: name))
        }

        for name in contentsNames {
            if name != ".DS_Store" {
                modelFileManager.append(ModelFileManager(type: .file, name: name))
            }

        }
        return modelFileManager
    }




    func createDirectory(nameFolder: String, completion: @escaping (String?) -> Void) {
        do {
            try FileManager.default.createDirectory(atPath: urlDocumentDirectoryString + "/" + nameFolder, withIntermediateDirectories: false)
        }
        catch {
            completion(error.localizedDescription)
            print(error.localizedDescription)

        }
    }




    func createFile(image: UIImage) {

        let data: NSData = image.pngData()! as NSData

        let timeData = String(describing: Date())
        let formatTimeData = timeData.replacingOccurrences(of: " ", with: "")

        let url = urlDocumentDirectoryString + "/\(formatTimeData)" + "_image"

            FileManager.default.createFile(atPath: url, contents: data as Data)
    }



    
    func removeContent(url: String, completion: @escaping (String?) -> Void) {

        guard let url = URL(string: String(describing: urlDocumentDirectoryURL) + url) else {
            return
        }

        do {
            try FileManager.default.removeItem(at: url)
        }
        catch {
            completion(error.localizedDescription)
            print(error)
        }

    }
}
