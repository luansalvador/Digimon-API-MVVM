//
//  Cell.swift
//  API-Digimon
//
//  Created by user220212 on 6/6/22.
//

import UIKit

class CustomCell: UITableViewCell {
    
    
    static var identifier = "CustomCell"
    
    private lazy var digimonImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.text = "testando"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(digimonImage)
        self.addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.digimonImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.digimonImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.digimonImage.heightAnchor.constraint(equalToConstant: 70),
            self.digimonImage.widthAnchor.constraint(equalToConstant: 70),
            
            self.label.leadingAnchor.constraint(equalTo: self.digimonImage.trailingAnchor, constant: 16),
            self.label.centerYAnchor.constraint(equalTo: self.digimonImage.centerYAnchor)
        ])
    }
    
    public func configureImage() -> UIImage {
        return digimonImage.image!
    }
    
    public func configureImageView() -> UIImageView {
        return digimonImage
    }
}
extension CustomCell: ConfigurableCellProtocol {
    func configureCell(text: String?, image: UIImage?) {
        self.label.text = text
        self.digimonImage.image = image
    }
}


