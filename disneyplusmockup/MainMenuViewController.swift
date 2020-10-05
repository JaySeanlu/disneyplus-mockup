//
//  MainMenuViewController.swift
//  disneyplusmockup
//
//  Created by Jason Lu on 10/3/20.
//

import UIKit

class MainMenuViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .black
        tabBar.isTranslucent = true
        setupTabBar()
        // Do any additional setup after loading the view.
    }
    
    func setupTabBar() {
        
        let videoController = UINavigationController(rootViewController: CarouselTableView())
        //videoController.addLogoToNavigationBarItem()
        videoController.navigationBar.barTintColor = .black
        videoController.title = "Home"

        
        let favoriteController = UINavigationController(rootViewController: CarouselTableView())
        //favoriteController.addLogoToNavigationBarItem()
        favoriteController.navigationBar.barTintColor = .black
        favoriteController.title = "Second"
        
        let searchController = UINavigationController(rootViewController: CarouselTableView())
        //favoriteController.addLogoToNavigationBarItem()
        searchController.navigationBar.barTintColor = .black
        searchController.title = "Third"
        
        let settingsController = UINavigationController(rootViewController: CarouselTableView())
        //favoriteController.addLogoToNavigationBarItem()
        settingsController.navigationBar.barTintColor = .black
        settingsController.title = "Fourth"
        
        viewControllers = [videoController, favoriteController, searchController, settingsController]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
