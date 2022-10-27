//
//  FileManagerAssembly.swift
//  FileManager
//
//  Created by Александр Хмыров on 21.10.2022.
//

import Foundation



class FileManagerAssembly {


    static func giveMeFileManagerViewController() ->
    FileManagerViewController {

        let fileManagerViewController = FileManagerViewController()
        let fileManagerService = FileManagerService()
        fileManagerViewController.fileManagerService = fileManagerService
        fileManagerViewController.view.backgroundColor = .white
        return fileManagerViewController
    }

}
