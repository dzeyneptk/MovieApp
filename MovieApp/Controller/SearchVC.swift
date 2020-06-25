//
//  MainVC.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var tableViewMovies: UITableView!
    @IBOutlet weak var navigationItemSearch: UINavigationItem!
    
    // MARK: - Private Parameters
    private var movieDetailVM = MovieDetailVM()
    private var createTableView = CreateTableView()
    private var data: String = ""
    private let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width), height: 70))
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailVM.delegate = self
        //  createTableView.configureTableView(tableView: tableViewMovies, searchBar: searchBar)
        configureTableView()
        configureSearchVC()
        navigationItem.hidesBackButton = true
    }
    override func viewDidAppear(_ animated: Bool) {
        ActivityIndicator.shared.stopEntryLoading()
    }
    
    // MARK: - Override Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstant.segueIdentifier.searchToDetail.description {
            let destination = segue.destination as! DetailVC
            destination.movieDetailVM = movieDetailVM
            
        }
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
extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForTextSearch(searchText: String){
        movieDetailVM.getMovieName(by: searchText)
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
            movieDetailVM.getMovieName(by: searchText)
        }
    }
}

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForTextSearch(searchText: searchController.searchBar.text!)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieDetailVM.getMovieName(by: self.data)
        performSegue(withIdentifier: AppConstant.segueIdentifier.searchToDetail.description, sender: nil)
    }
}

// MARK: - MovieDetailDelegte
extension SearchVC: MovieDetailDelegate {
    
    func failWith(error: String?) {
        print(error ?? "")
    }
    
    func succes() {
        data.removeAll()
        data = movieDetailVM.getString ?? "Movie not found!"
        if (data == ""){
            data = "Movie not found!"
        }
        self.tableViewMovies.reloadData()
    }
}

