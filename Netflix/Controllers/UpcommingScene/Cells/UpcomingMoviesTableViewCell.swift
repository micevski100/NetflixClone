//
//  UpcomingMoviesTableViewCell.swift
//  Netflix
//
//  Created by Aleksandar Micevski on 26.6.22.
//

import UIKit

class UpcomingMoviesTableViewCell: UITableViewCell {
    
    static let identifier = "UpcomingMoviesTableViewCell"
    var posterImageView: UIImageView!
    var titleLabel: UILabel!
    var playButton: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        posterImageView = UIImageView()
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        self.contentView.addSubview(posterImageView)
        
        titleLabel = UILabel()
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        self.contentView.addSubview(titleLabel)
        
        playButton = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        playButton.setImage(image, for: .normal)
        playButton.tintColor = .black
        self.contentView.addSubview(playButton)
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(15)
            make.left.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-15)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(posterImageView.snp.right).offset(15)
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(playButton.snp.left)
        }
        
        playButton.snp.makeConstraints { make in
            make.right.equalTo(self.contentView).offset(-15)
            make.centerY.equalTo(self.contentView)
        }
    }
    
    func configure(movie: Movie) {
        guard let posterPath = movie.poster_path else {return}
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else {return}
        posterImageView.kf.setImage(with: url)
        titleLabel.text = movie.original_title
    }
}
