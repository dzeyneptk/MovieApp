//
//  MainVC.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableViewMovies: UITableView!
    
    // MARK: - Private Parameters
    private var data: [String] = []
    private let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width), height: 70))
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private Functions
    private func configureTableView(){
        self.tableViewMovies.delegate = self
        self.tableViewMovies.dataSource = self
        self.tableViewMovies.tableHeaderView = searchBar
        self.tableViewMovies.backgroundColor = UIColor.white
        self.tableViewMovies.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func configureSearchVC(){
        searchBar.delegate = self
        searchBar.placeholder = "Search Movie"
        searchBar.searchBarStyle = .minimal
        searchBar.isUserInteractionEnabled = true
        searchBar.sizeToFit()
        definesPresentationContext = true
    }
}

// MARK: - UISearchDelegate
extension MainVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForTextSearch(searchText: String){
        googlePlaceVM.placeAutoComplete(text: searchText)
        self.tableViewMovies.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        self.tableViewMovies.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.tableViewMovies.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBarIsEmpty()){
            searchBar.text = ""
        } else {
            googlePlaceVM.placeAutoComplete(text: searchText)
        }
    }
}

extension MainVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForTextSearch(searchText: searchController.searchBar.text!)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return googlePlaceVM.placeCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        googleMapsVM.getGeocode(by: self.data[indexPath.row])
    }
}
