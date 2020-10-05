//
//  ViewController.swift
//  disneyplusmockup
//
//  Created by Jason Lu on 9/21/20.
//

import UIKit

struct MoviePoster {
    var title: String
    var image: UIImage
    var parentalControls: Bool
}

func loadImages(header:String, movieLen: Int) -> [MoviePoster] {
    var returnArray:[MoviePoster] = []
    for i in 0...movieLen-1 {
        let imageTitle = header + String(i+1)
        returnArray.append(MoviePoster(title: imageTitle, image: UIImage(named: imageTitle)!, parentalControls: false))
    }
    return returnArray
}

class MovieCollectionCell: UITableViewCell {
    
    let moviesArray = loadImages(header: "top", movieLen: 7)
    
    private lazy var navigationController: UINavigationController = {
       let tabBarController = UIApplication.shared.windows.first!.rootViewController as! UITabBarController
        var window = tabBarController.selectedViewController
        while window?.presentedViewController != nil {
            if let current =  window?.presentedViewController as? UINavigationController{
                window = current
               }
         }
        return window as! UINavigationController
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = true
        cv.showsHorizontalScrollIndicator = false

        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //register what constitutes a cell
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "cell")
        
        self.contentView.addSubview(collectionView) //used to be just self.addSubView
        
        //how to make this the same as parent
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        //make the height of the CollectionView only as big as one cell (which is width/2)
        //collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieCollectionCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MovieCell else {return UICollectionViewCell()}
        cell.targetPoster = self.moviesArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let desVC = VideoPlayerScreen()
        desVC.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(desVC, animated: true)
        
    }
}
