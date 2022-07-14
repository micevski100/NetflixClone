//
//  SearchViewController.swift
//  Netflix
//
//  Created by Aleksandar Micevski on 23.6.22.
//

import UIKit

class SearchViewController: UIViewController {
    
    var discoverTable: UITableView!
    var movies: [Movie] = []
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
        getDiscoverMovies()
    }
    
    func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        searchController = UISearchController(searchResultsController: SearchResultsViewController())
        searchController.searchBar.placeholder = "Search for a movie"
        searchController.searchBar.searchBarStyle = .minimal
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.searchController = searchController
        
        discoverTable = UITableView()
        discoverTable.register(UpcomingMoviesTableViewCell.self, forCellReuseIdentifier: UpcomingMoviesTableViewCell.identifier)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        self.view.addSubview(discoverTable)
    }
    
    func setupConstraints() {
        discoverTable.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = discoverTable.dequeueReusableCell(withIdentifier: UpcomingMoviesTableViewCell.identifier ) as! UpcomingMoviesTableViewCell
        cell.configure(movie: self.movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension SearchViewController {
    func getDiscoverMovies() {
        APIManager.sharedInstance.getDiscoverMovies { success, responseObject, statusCode in
            if success {
                do {
                    let data = Utilities.sharedInstance.jsonToData(json: responseObject ?? [:])
                    let results = try JSONDecoder().decode(MoviesResponse.self, from: data!)
                    self.movies = results.results
                    DispatchQueue.main.async {
                        self.discoverTable.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                
            }
        }
    }
}
