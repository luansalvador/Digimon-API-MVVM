//
//  DigimonListViewController.swift
//  API-Digimon
//
//  Created by user220212 on 6/6/22.
//

import UIKit
import Kingfisher

protocol DigimonListViewControllerDelegate: AnyObject {
    func getImageUrl(url: URL?)
}

class DigimonListViewController: UIViewController {
    
    private let tableView = TableView()
    private let viewModel: DigimonViewModel
    weak var delegate: DigimonListViewControllerDelegate?
    
    private var allDigimons: [DigimonModel]?
    private var urlFromString: URL?
    private var actualCell: UITableViewCell?
    
    init(viewModel: DigimonViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lista de Digimons"
        setupView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getDigimons()
    }
    
    private func setupView() {
        tableView.setupTableViewDelegate(parent: self)
        self.view = tableView
    }
    
    private func getDigimons() {
        self.viewModel.fetchDigimons()
        self.tableView.configureTableView().reloadData()
    }

}
extension DigimonListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let allDigimons = self.allDigimons else {
            return 0
        }
        return allDigimons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell
        guard let allDigimons = self.allDigimons else { return UITableViewCell() }
        let digimonIndex = allDigimons[indexPath.row]
        self.urlFromString = URL(string: digimonIndex.img ?? "")
        guard let url = urlFromString else { return UITableViewCell() }
        print(digimonIndex)
        cell?.configureCell(text: digimonIndex.name, url: url)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.delegate?.getImageUrl(url: self.urlFromString)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension DigimonListViewController: DigimonViewModelDelegate {
    func updateView(digimons: [DigimonModel]) {
        DispatchQueue.main.async {
            self.allDigimons = digimons
            self.tableView.configureTableView().reloadData()
        }
    }
}

