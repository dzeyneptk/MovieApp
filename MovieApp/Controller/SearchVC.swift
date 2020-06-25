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
    
    // MARK: - Private Parameters
    private var movieDetailVM = MovieDetailVM()
    private let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width), height: 70))
    private var isEmpty = true
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Gradient.shared.addGradientToView(view: view)
        configureTableView()
        configureSearchVC()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ActivityIndicator.shared.stopEntryLoading()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieDetailVM.delegate = self
        isEmpty = true
        searchBar.text = ""
        tableViewMovies.reloadData()
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
        self.tableViewMovies.backgroundColor = UIColor.clear
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
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isEmpty = true
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.tableViewMovies.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBarIsEmpty()){
            self.isEmpty = true
            searchBar.text = ""
            self.tableViewMovies.reloadData()
        } else {
            self.isEmpty = false
            movieDetailVM.getMovieName(by: searchText)
        }
    }
}

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let textKey = searchController.searchBar.text {
             filterContentForTextSearch(searchText: textKey)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if isEmpty {
            cell.textLabel?.text = ""
        } else {
            cell.textLabel?.text = movieDetailVM.getString
        }
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: AppConstant.segueIdentifier.searchToDetail.description, sender: nil)
    }
}

// MARK: - MovieDetailDelegte
extension SearchVC: MovieDetailDelegate {
    func succes() {
        self.isEmpty = false
        self.tableViewMovies.reloadData()
    }
    
    func failWith(error: String?) {
        print(error ?? "")
    }
}

