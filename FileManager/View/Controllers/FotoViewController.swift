//
//  FotoViewController.swift
//  FileManager
//
//  Created by Александр Хмыров on 25.10.2022.
//

import UIKit

class FotoViewController: UIViewController {

    lazy var imageViewFoto: UIImageView = {
        var imageViewFoto = UIImageView()
        imageViewFoto.translatesAutoresizingMaskIntoConstraints = false
        imageViewFoto.backgroundColor = .white
        imageViewFoto.clipsToBounds = true
        imageViewFoto.contentMode = .scaleAspectFit
        return imageViewFoto
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.imageViewFoto)

        NSLayoutConstraint.activate([
            self.imageViewFoto.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.imageViewFoto.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.imageViewFoto.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.imageViewFoto.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

    }
    


}
