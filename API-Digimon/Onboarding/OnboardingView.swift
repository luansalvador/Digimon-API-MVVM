//
//  OnboardingView.swift
//  API-Digimon
//
//  Created by user220212 on 6/8/22.
//

import UIKit

protocol UpadateViewProtocol {
    func setImageFromUrl(url: URL)
}

class OnboardingView: UIView {
    
    var choiceAction: (() -> Void)?
    
    private lazy var button: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Escolha seu Digimon", for: .normal)
        view.backgroundColor = .systemBlue
        view.addTarget(self, action: #selector(performChoice), for: .touchUpInside)
        view.layer.cornerRadius = 9
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "interrogacao-img")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var digimonNameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        setupAdtionalConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(button)
        self.addSubview(imageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            self.button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.button.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor),
            self.button.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor),
            self.button.heightAnchor.constraint(equalToConstant: 50),
            
            self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8)
        ])
    }
    
    private func setupAdtionalConfig() {
        self.backgroundColor = .white
    }
    
    @objc private func performChoice() {
        self.choiceAction?()
    }    
}

extension OnboardingView: UpadateViewProtocol {
    func setImageFromUrl(url: URL) {
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: url)
        }
        
    }
}
