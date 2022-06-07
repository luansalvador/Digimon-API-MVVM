//
//  ViewController.swift
//  API-Digimon
//
//  Created by user220212 on 6/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = TableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lista de Digimons"
        setupView()
        DigimonViewModelNetworking.getDigimon { (digimons) in
            DigimonViewModelNetworking.digimonsArray = digimons
            DispatchQueue.main.async {
                self.tableView.configureTableView().reloadData()
            }
        }
    }

    private func setupView() {
        tableView.setupTableViewDelegate(parent: self)
        self.view = tableView
    }

}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DigimonViewModelNetworking.digimonsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let digimonViewModelNetworking = DigimonViewModelNetworking()
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell
        let digimonIndex = DigimonViewModelNetworking.digimonsArray[indexPath.row]
        digimonViewModelNetworking.digimonIMG(at: indexPath, imageView: cell?.configureImage())
    
        cell?.configureCell(text: digimonIndex.name)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

