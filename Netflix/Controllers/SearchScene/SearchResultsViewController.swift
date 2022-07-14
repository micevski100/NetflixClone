//
//  SearchResultsViewController.swift
//  Netflix
//
//  Created by Aleksandar Micevski on 26.6.22.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    var searchResultsCollectionView: UICollectionView!
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.view.backgroundColor = .red
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.size.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        searchResultsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        searchResultsCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        self.view.addSubview(searchResultsCollectionView)
    }
    
    func setupConstraints() {
        searchResultsCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchResultsCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.backgroundColor = .red
        return cell
    }
}
