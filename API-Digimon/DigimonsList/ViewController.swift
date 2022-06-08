//
//  ViewController.swift
//  API-Digimon
//
//  Created by user220212 on 6/6/22.
//

import UIKit

protocol SendImageDelegate: AnyObject {
    func getImage(image: UIImage)
}

class ViewController: UIViewController {
    
    let tableView = TableView()
    let networking = Networking()
    var digimonViewModel = DigimonViewModel(digimons: [DigimonModel.init(name: "", img: "", level: "")])
    weak var delegate: SendImageDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lista de Digimons"
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        Networking.getDigimons { (digimonsResponse) in
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
        //let networking = Networking()
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell
        let digimonIndex = digimonViewModel.digimons[indexPath.row]
        networking.digimonIMG(stringToURL: digimonIndex.img, imageView: cell?.configureImageView())
        cell?.configureCell(text: digimonIndex.name)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stringLink = digimonViewModel.digimons[indexPath.row].img
        guard let url = URL(string: stringLink) else { return }
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            guard let data = data else { print("caiu aqui") ;return }
            let image = UIImage(data: data)
           DispatchQueue.main.async { [self] in
                delegate?.getImage(image: image!)
               self.navigationController?.popViewController(animated: true)
               
           }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

