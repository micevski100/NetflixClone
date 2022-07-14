//
//  HeroHeaderUIView.swift
//  Netflix
//
//  Created by Aleksandar Micevski on 23.6.22.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    var heroImageView: UIImageView!
    var playButtton: UIButton!
    var downloadButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        heroImageView = UIImageView()
        heroImageView.contentMode = .scaleAspectFill
        heroImageView.clipsToBounds = true
        heroImageView.image = UIImage(named: "heroImage")
        self.addSubview(heroImageView)
        
        addGradient()
        
        playButtton = UIButton()
        playButtton.setTitle("Play", for: .normal)
        playButtton.setTitleColor(.black, for: .normal)
        playButtton.layer.borderColor = UIColor.black.cgColor
        playButtton.layer.borderWidth = 1
        playButtton.translatesAutoresizingMaskIntoConstraints = false
        playButtton.layer.cornerRadius = 5
        self.addSubview(playButtton)
        
        downloadButton = UIButton()
        downloadButton.setTitle("Download", for: .normal)
        downloadButton.setTitleColor(.black, for: .normal)
        downloadButton.layer.borderColor = UIColor.black.cgColor
        downloadButton.layer.borderWidth = 1
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.layer.cornerRadius = 5
        self.addSubview(downloadButton)
    }
    
    func setupConstraints() {
        heroImageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        playButtton.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-20)
            make.width.equalTo(100)
            make.right.equalTo(self.snp.centerX).offset(-5)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-20)
            make.width.equalTo(100)
            make.left.equalTo(self.snp.centerX).offset(5)
        }
    }
    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
}
