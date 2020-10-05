//
//  CollectionViewCell.swift
//  disneyplusmockup
//
//  Created by Jason Lu on 9/21/20.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    var targetPoster: MoviePoster? {
        didSet {
            guard let targetPoster = targetPoster else {return}
            bg.image = targetPoster.image
        }
    }
    
    private lazy var bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 8.0
        iv.clipsToBounds = true
        iv.widthAnchor.constraint(equalToConstant: 120).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 160).isActive = true
        iv.backgroundColor = .black
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(bg)
        let bottomConstraint = self.bg.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        bottomConstraint.priority = .required - 1
        
        // Needed to avoid the `UIView-Encapsulated-Layout-Width` issue
        let trailingConstraint = self.bg.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        trailingConstraint.priority = .required - 1
        NSLayoutConstraint.activate([
            self.bg.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.bg.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            trailingConstraint,
            bottomConstraint
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
