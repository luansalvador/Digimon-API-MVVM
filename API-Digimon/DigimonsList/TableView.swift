//
//  TableView.swift
//  API-Digimon
//
//  Created by user220212 on 6/6/22.
//

import UIKit

class TableView: UIView {
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        setupAditionalConfigurations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupAditionalConfigurations() {
            self.backgroundColor = .white
        }
        
    public func setupTableViewDelegate(parent: UITableViewDelegate & UITableViewDataSource) {
        self.tableView.delegate = parent
        self.tableView.dataSource = parent
    }
    
    public func configureTableView() -> UITableView {
        return self.tableView
    }
    
}
