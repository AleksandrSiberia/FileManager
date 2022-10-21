//
//  FileManagerService.swift
//  FileManager
//
//  Created by Александр Хмыров on 21.10.2022.
//

import Foundation



class FileManagerService: FileManagerServiceProtocol {


    func contentsOfDirectory() -> [ModelFileManager] {

        let urlDocumentDirectory2 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let urlDocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

        var modelFileManager: [ModelFileManager] = []

        let folderURL =  try? FileManager.default.contentsOfDirectory(at: urlDocumentDirectory, includingPropertiesForKeys: [], options: []).filter({ URL in
            URL.hasDirectoryPath
        })

        do {

            let _: [()] = try FileManager.default.contentsOfDirectory(atPath: urlDocumentDirectory2).map({ content in
                let urlContent = String(describing: urlDocumentDirectory).appending("\(content)/")
                modelFileManager.append(ModelFileManager(type: .file, name: content, url: urlContent))
            })
        }

        catch {
            print(error.localizedDescription)
        }

        for (index, model) in modelFileManager.enumerated(){
            for urlFolder in folderURL! {
                if model.url == String(describing: urlFolder) {

                    var newModel = model
                    modelFileManager.remove(at: index)
                    newModel.type = .folder
                    modelFileManager.insert(newModel, at: index)
                }
            }

        }
 //       print("modelFileManager", modelFileManager)
        return modelFileManager
    }



    func createDirectory() {

    }

    func createFile() {

    }

    func removeContent() {

    }
}
