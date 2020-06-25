//
//  CreateTableView.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation
import UIKit

class CreateTableView: UIViewController {
    static let shared = CreateTableView()
    // MARK: -  Functions
    func configureTableView(tableView: UITableView, searchBar: UISearchBar){
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self as? UITableViewDataSource
        tableView.tableHeaderView = searchBar
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
