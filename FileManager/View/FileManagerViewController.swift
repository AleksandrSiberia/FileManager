//
//  ViewController.swift
//  FileManager
//
//  Created by Александр Хмыров on 21.10.2022.
//

import UIKit

class FileManagerViewController: UIViewController {

    var fileManagerService: FileManagerServiceProtocol?

    private var modelFileManager: [ModelFileManager] = []

    var nameViewController: String = ""


    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FileManagerTableViewCell.self, forCellReuseIdentifier: FileManagerTableViewCell.name)

        return tableView
    }()

    
    private lazy var barButtonItemAddFolder: UIBarButtonItem = {
        var barButtonItemAddFolder = UIBarButtonItem(image: UIImage(systemName: "folder.fill.badge.plus"), style: .plain, target: self, action: #selector(barButtonItemAddFolderAction))
        return barButtonItemAddFolder
    }()


    private lazy var imagePicker: UIImagePickerController = {
        var imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false

        return imagePicker
    }()



    private lazy var barButtonItemAddImage: UIBarButtonItem = {
        var barButtonItemAddImage = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(barButtonItemAddImageAction))
        return barButtonItemAddImage
    }()


    override func viewDidLoad() {
        super.viewDidLoad()


        self.imagePicker.delegate = self

        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])

        self.view.addSubview(self.tableView)

        self.navigationItem.setRightBarButtonItems([barButtonItemAddImage, barButtonItemAddFolder], animated: true)

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if self.navigationItem.title != "Documents"  {

            let newNameViewController = self.nameViewController.appending( self.navigationItem.title! + "/")
            self.nameViewController = newNameViewController

        }


        guard FileManager.default.fileExists(atPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/" + self.nameViewController)  else {

            self.modelFileManager = self.fileManagerService?.contentsOfDirectory(nameNewDirectory: "", completionURL: { url, string in
            }) ?? []
            self.tableView.reloadData()
            return
        }
        self.modelFileManager = self.fileManagerService?.contentsOfDirectory(nameNewDirectory: self.nameViewController, completionURL: { url, string in
        }) ?? []
        self.tableView.reloadData()

    }


    private func reloadMyData() {

        self.modelFileManager =
        self.fileManagerService?.contentsOfDirectory(nameNewDirectory: "", completionURL: { url, string in
        }) ?? []
        self.tableView.reloadData()
    }

   

    @objc func barButtonItemAddFolderAction() {
        let alert = UIAlertController(title: "Создать новую папку", message: nil, preferredStyle: .alert)

        var textFieldName: UITextField?
        
        alert.addTextField { textFieldNameNewFolder in
            textFieldNameNewFolder.placeholder = "Имя папки"
            textFieldName = textFieldNameNewFolder
            textFieldName?.text = "NewFolder"

        }

        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(actionCancel)

        let actionCreate = UIAlertAction(title: "Создать", style: .default) { _ in

            self.fileManagerService?.createDirectory(nameFolder:  textFieldName?.text ?? "NewFolder", completion: { error in

                if let error {
                    let alert = UIAlertController()
                    let alertAction = UIAlertAction(title: error, style: .default)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true)
                }
                else {
                    return
                }
            })
            self.reloadMyData()

        }
        alert.addAction(actionCreate)
        self.present(alert, animated: true)

    }

    @objc func barButtonItemAddImageAction() {

        self.present(self.imagePicker, animated: true)

    }
}

extension FileManagerViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelFileManager.count
    }




    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let nameDocuments = self.modelFileManager[indexPath.row].name
        let type = self.modelFileManager[indexPath.row].type

        let cell = tableView.dequeueReusableCell(withIdentifier: FileManagerTableViewCell.name, for: indexPath) as! FileManagerTableViewCell

        cell.setupInfoTableViewCell(nameDocuments)

        if type == .folder {
            cell.accessoryType = .disclosureIndicator
            cell.setupMiniImage(image: UIImage(systemName: "folder")!)
            return cell
        }

        else {
            cell.accessoryType = .none
            self.fileManagerService?.openFoto(nameFoto: self.modelFileManager[indexPath.row].name, completion: { image in
                cell.setupMiniImage(image: image)
            })


            return cell
        }
    }




    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if self.modelFileManager[indexPath.row].type == .folder {
            let viewController = FileManagerAssembly.giveMeFileManagerViewController()

            var nameSelfTitle = ""

            if self.navigationItem.title != "Documents" {
                nameSelfTitle = self.navigationItem.title! + "/"
            }

            viewController.navigationItem.title = nameSelfTitle + self.modelFileManager[indexPath.row].name

            self.navigationController?.pushViewController(viewController, animated: true)
        }
        else {

            self.fileManagerService?.openFoto(nameFoto: self.modelFileManager[indexPath.row].name) { image in

                    let vcFoto = FotoViewController()
                    vcFoto.view.backgroundColor = .white
                    vcFoto.imageViewFoto.image = image

                    self.present(vcFoto, animated: true)
                }
            }
        }




    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let urlDeleteString = self.modelFileManager[indexPath.row].name

            let alert = UIAlertController(title: "Удалить?", message: nil , preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "да", style: .destructive) {_ in
                self.fileManagerService?.removeContent (url: urlDeleteString, completion: { error in
                })
                self.reloadMyData()
            }
            alert.addAction(actionOk)
            let actionCancel = UIAlertAction(title: "нет", style: .cancel)
            alert.addAction(actionCancel)
            self.present(alert, animated: true)
    }
    }
}



extension FileManagerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {


            self.fileManagerService?.createFile(image: pickedImage)
            self.dismiss(animated: true)

            reloadMyData()

        }
    }
}



