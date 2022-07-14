//
//  HomeViewController.swift
//  Netflix
//
//  Created by Aleksandar Micevski on 23.6.22.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTV = 1
    case Popular = 2
    case Upcoming = 3
    case Toprated = 4
}

class HomeViewController: UIViewController {
    
    var sectionTitles: [String] = ["Trending Movies", "Popular", "Trending TV", "Upcoming Movies", "Top Rated"]
    var trendingMovies: [Movie] = []
    var trendingTV: [Movie] = []
    var popularMovies: [Movie] = []
    var upcomingMovies: [Movie] = []
    var topRatedMovies: [Movie] = []
    var homeFeedTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
        
        getTrendingMovies()
        getTrendingTVs()
        getUpcommingMovies()
        getPopularMovies()
        getTopRatedMovies()
    }
    
    func setupViews() {
        self.view.backgroundColor = .systemBackground
        
        setupNavBar()
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 450))
        
        homeFeedTable = UITableView(frame: .zero, style: .grouped)
        homeFeedTable.backgroundColor = .clear
        homeFeedTable.tableHeaderView = headerView
        homeFeedTable.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        self.view.addSubview(homeFeedTable)
    }
    
    func setupConstraints() {
        homeFeedTable.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
    
    func setupNavBar() {
        let containerView = UIControl(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        containerView.addTarget(self, action: #selector(logoTapped), for: .touchUpInside)
        let image = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        image.image = UIImage(named: "netflixLogo")
        containerView.addSubview(image)
        let logoBarButtonItem = UIBarButtonItem(customView: containerView)
        navigationItem.leftBarButtonItem = logoBarButtonItem
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func logoTapped() {
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeFeedTable.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier) as! CollectionViewTableViewCell
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            cell.configure(movies: trendingMovies)
        case Sections.TrendingTV.rawValue:
            cell.configure(movies: trendingTV)
        case Sections.Popular.rawValue:
            cell.configure(movies: popularMovies)
        case Sections.Upcoming.rawValue:
            cell.configure(movies: upcomingMovies)
        case Sections.Toprated.rawValue:
            cell.configure(movies: topRatedMovies)
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .black
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = self.view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        self.navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController {
    private func getTrendingMovies() {
        APIManager.sharedInstance.getTrendingMovies { success, responseObject, statusCode in
            if success {
                do {
                    let data = Utilities.sharedInstance.jsonToData(json: responseObject ?? [:])
                    let results = try JSONDecoder().decode(MoviesResponse.self, from: data!)
                    self.trendingMovies = results.results
                    DispatchQueue.main.async {
                        self.homeFeedTable.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                
            }
        }
    }
    
    private func getTrendingTVs() {
        APIManager.sharedInstance.getTrendingTVs { success, responseObject, statusCode in
            if success {
                do {
                    let data = Utilities.sharedInstance.jsonToData(json: responseObject ?? [:])
                    let results = try JSONDecoder().decode(MoviesResponse.self, from: data!)
                    self.trendingTV = results.results
                    DispatchQueue.main.async {
                        self.homeFeedTable.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                
            }
        }
    }
    
    private func getUpcommingMovies() {
        APIManager.sharedInstance.getUpcomingMovies { success, responseObject, statusCode in
            if success {
                do {
                    let data = Utilities.sharedInstance.jsonToData(json: responseObject ?? [:])
                    let results = try JSONDecoder().decode(MoviesResponse.self, from: data!)
                    self.upcomingMovies = results.results
                    DispatchQueue.main.async {
                        self.homeFeedTable.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                
            }
        }
    }
    
    private func getPopularMovies() {
        APIManager.sharedInstance.getPopularMovies { success, responseObject, statusCode in
            if success {
                do {
                    let data = Utilities.sharedInstance.jsonToData(json: responseObject ?? [:])
                    let results = try JSONDecoder().decode(MoviesResponse.self, from: data!)
                    self.popularMovies = results.results
                    DispatchQueue.main.async {
                        self.homeFeedTable.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                
            }
        }
    }
    
    private func getTopRatedMovies() {
        APIManager.sharedInstance.getTopRatedMovies { success, responseObject, statusCode in
            if success {
                do {
                    let data = Utilities.sharedInstance.jsonToData(json: responseObject ?? [:])
                    let results = try JSONDecoder().decode(MoviesResponse.self, from: data!)
                    self.topRatedMovies = results.results
                    DispatchQueue.main.async {
                        self.homeFeedTable.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                
            }
        }
    }
}
