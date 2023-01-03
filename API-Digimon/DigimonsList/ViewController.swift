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
    
    private let tableView = TableView()
    private let viewModel: DigimonViewModel
    //var digimonViewModel = DigimonViewModel(digimons: [DigimonModel.init(name: "", img: "", level: "")])
    weak var delegate: SendImageDelegate?
    private var allDigimons: [DigimonModel]?
    
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
        DispatchQueue.main.async {
            self.getDigimons()
            self.tableView.configureTableView().reloadData()
            print(self.allDigimons?.count)
        }
        //getDigimons()
        //print(allDigimons?.count)
//        Service.getDigimons { (digimonsResponse) in
//            self.digimonViewModel.digimons = digimonsResponse
//            DispatchQueue.main.async {
//                self.tableView.configureTableView().reloadData()
//            }
//        }
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
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let allDigimons = self.allDigimons else {
            return 0
        }
        return allDigimons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let networking = Networking()
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell
        guard let allDigimons = self.allDigimons else {
            return UITableViewCell()
        }
        let digimonIndex = allDigimons[indexPath.row]
        let imageFromString = UIImage(named: digimonIndex.img)
        //let digimonIndex = digimonViewModel.digimons[indexPath.row]
        //service.digimonIMG(stringToURL: digimonIndex.img, imageView: cell?.configureImageView())
        cell?.configureCell(text: digimonIndex.name, image: imageFromString)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let stringLink = digimonViewModel.digimons[indexPath.row].img
//        guard let url = URL(string: stringLink) else { return }
//        URLSession.shared.dataTask(with: url) { [self] data, response, error in
//            guard let data = data else { print("caiu aqui") ;return }
//            let image = UIImage(data: data)
//           DispatchQueue.main.async { [self] in
//                delegate?.getImage(image: image!)
//               self.navigationController?.popViewController(animated: true)
//               
//           }
//        }.resume()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension ViewController: DigimonViewModelDelegate {
    func updateView(digimons: [DigimonModel]) {
        self.allDigimons = digimons
    }
    
}

