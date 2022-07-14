//
//  UpcommingViewController.swift
//  Netflix
//
//  Created by Aleksandar Micevski on 23.6.22.
//

import UIKit

class UpcommingViewController: UIViewController {

    var upcomingTable: UITableView!
    var upcominMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
        getUpcommingMovies()
    }
    
    func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.title = "Upcoming"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        upcomingTable = UITableView()
        upcomingTable.register(UpcomingMoviesTableViewCell.self, forCellReuseIdentifier: UpcomingMoviesTableViewCell.identifier)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        self.view.addSubview(upcomingTable)
    }
    
    func setupConstraints() {
        upcomingTable.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
}

extension UpcommingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.upcominMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = upcomingTable.dequeueReusableCell(withIdentifier: UpcomingMoviesTableViewCell.identifier) as! UpcomingMoviesTableViewCell
        cell.configure(movie: self.upcominMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension UpcommingViewController {
    func getUpcommingMovies() {
        APIManager.sharedInstance.getUpcomingMovies { success, responseObject, statusCode in
            if success {
                do {
                    let data = Utilities.sharedInstance.jsonToData(json: responseObject ?? [:])
                    let results = try JSONDecoder().decode(MoviesResponse.self, from: data!)
                    self.upcominMovies = results.results
                    DispatchQueue.main.async {
                        self.upcomingTable.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                
            }
        }
    }
}
