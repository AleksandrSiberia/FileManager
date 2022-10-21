//
//  ViewController.swift
//  FileManager
//
//  Created by Александр Хмыров on 21.10.2022.
//

import UIKit

class FileManagerViewController: UIViewController {

    var fileManagerService: FileManagerServiceProtocol?

    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FileManagerTableViewCell.self, forCellReuseIdentifier: FileManagerTableViewCell.name)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)



        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension FileManagerViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fileManagerService?.contentsOfDirectory().count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: FileManagerTableViewCell.name, for: indexPath) as! FileManagerTableViewCell

        cell.setupInfoTableViewCell(self.fileManagerService?.contentsOfDirectory()[indexPath.row].name ?? "пусто")

        if self.fileManagerService?.contentsOfDirectory()[indexPath.row].type == .folder {
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
}




