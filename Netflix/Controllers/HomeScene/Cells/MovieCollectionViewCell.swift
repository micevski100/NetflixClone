//
//  MovieCollectionViewCell.swift
//  Netflix
//
//  Created by Aleksandar Micevski on 25.6.22.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    var posterImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        posterImageView = UIImageView()
        posterImageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(posterImageView)
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView)
        }
    }
    
    func configure(posterUrl: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterUrl)") else {return}
        posterImageView.kf.setImage(with: url)
    }
}
