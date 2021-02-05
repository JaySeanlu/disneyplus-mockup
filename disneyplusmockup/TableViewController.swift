//
//  CarouselTableView.swift
//  disneyplusmockup
//
//  Created by Jason Lu on 9/21/20.
//

import UIKit

class CarouselTableView: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black//UIColor(red: 101/256, green: 115/256, blue: 126/256, alpha: 1.0)
        
        tableView.register(MovieCollectionCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.rowHeight = 180 //Check
        
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    var sectionTitles: [String] = ["Recommended For You", "New to Disney+", "Hit Movies", "Originals", "Trending"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLogoToNavigationBarItem()

//        let addButton = UIBarButtonItem(title: "Remote", style: UIBarButtonItem.Style.done, target: self, action: #selector(tapButton))
//        self.navigationItem.rightBarButtonItem = addButton
        view.backgroundColor = .black
        view.addSubview(tableView)
        
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
     }
    
//    @objc func tapButton() {
//        let desVC = RemoteViewController()
//        self.navigationController?.pushViewController(desVC, animated: true)
//    }
}

extension CarouselTableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieCollectionCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? MovieCollectionCell else {
            assertionFailure("TableViewCell is nil")
            return UITableViewCell()
        }
        return cell
    }
}

