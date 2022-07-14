//
//  MainViewController.swift
//  Netflix
//
//  Created by Aleksandar Micevski on 23.6.22.
//

import UIKit
import SnapKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTabBar()
    }
    
    func setupTabBar() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        
        let upcommingVC = UINavigationController(rootViewController: UpcommingViewController())
        upcommingVC.tabBarItem = UITabBarItem(title: "Coming soon", image: UIImage(systemName: "play.circle"), tag: 2)
        
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        searchVC.tabBarItem = UITabBarItem(title: "Top Search", image: UIImage(systemName: "play.circle"), tag: 2)
        
        let downloadsVC = UINavigationController(rootViewController: DownloadsViewController())
        downloadsVC.tabBarItem = UITabBarItem(title: "Downloads", image: UIImage(systemName: "arrow.down.to.line"), tag: 3)
        
        tabBar.tintColor = .label
        
        self.viewControllers = [homeVC, upcommingVC, searchVC, downloadsVC]
    }
}
