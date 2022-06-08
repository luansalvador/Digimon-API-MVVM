//
//  ViewController.swift
//  API-Digimon
//
//  Created by user220212 on 6/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = TableView()
    var digimonViewModel = DigimonViewModel(digimons: [DigimonModel.init(name: "", img: "", level: "")])
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lista de Digimons"
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        DigimonViewModelNetworking.getDigimons { (digimonsResponse) in
            self.digimonViewModel.digimons = digimonsResponse
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
        return digimonViewModel.digimons.count 
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let digimonViewModelNetworking = DigimonViewModelNetworking()
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell
        let digimonIndex = digimonViewModel.digimons[indexPath.row]
        digimonViewModelNetworking.digimonIMG(stringToURL: digimonIndex.img, imageView: cell?.configureImage())
    
        cell?.configureCell(text: digimonIndex.name)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

