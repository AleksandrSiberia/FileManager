//
//  FileManagerTableViewCell.swift
//  FileManager
//
//  Created by Александр Хмыров on 21.10.2022.
//

import UIKit

protocol NameFileManagerTableViewCell {
    static var name: String { get }
}

class FileManagerTableViewCell: UITableViewCell {

    var modelFileManager: ModelFileManager?

    private lazy var labelContentDocuments: UILabel = {
        var labelPlanetResident = UILabel()
        labelPlanetResident.translatesAutoresizingMaskIntoConstraints = false
        labelPlanetResident.backgroundColor = .white
        return labelPlanetResident
    }()

    private lazy var imageViewMiniFoto: UIImageView = {
        var imageViewMiniFoto = UIImageView()
        imageViewMiniFoto.translatesAutoresizingMaskIntoConstraints = false
        imageViewMiniFoto.backgroundColor = .white
        imageViewMiniFoto.clipsToBounds = true
        imageViewMiniFoto.contentMode = .scaleAspectFit
        return imageViewMiniFoto
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(labelContentDocuments)
        self.addSubview(imageViewMiniFoto)

        NSLayoutConstraint.activate([
            self.imageViewMiniFoto.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageViewMiniFoto.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageViewMiniFoto.widthAnchor.constraint(equalToConstant: 50),
            self.imageViewMiniFoto.centerYAnchor.constraint(equalTo: self.centerYAnchor),



            self.labelContentDocuments.centerYAnchor.constraint(equalTo: self.imageViewMiniFoto.centerYAnchor),
            self.labelContentDocuments.leadingAnchor.constraint(equalTo: self.imageViewMiniFoto.trailingAnchor, constant: 10),
            self.labelContentDocuments.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.labelContentDocuments.bottomAnchor.constraint(equalTo: self.bottomAnchor),

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupInfoTableViewCell(_ nameDocument: String) {
        self.labelContentDocuments.text = nameDocument
    }

    func setupMiniImage(image: UIImage) {
        self.imageViewMiniFoto.image = image
    }

    func openView() -> Bool {
        if self.modelFileManager?.type == .folder {
            return true
        }
        return false
    }
}

extension FileManagerTableViewCell: NameFileManagerTableViewCell {

    static var name: String {
        return String(describing: self)
    }


}




