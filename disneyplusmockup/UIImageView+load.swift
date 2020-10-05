//
//  UIViewController+addLogo.swift
//  disneyplusmockup
//
//  Created by Jason Lu on 10/3/20.
//

import Foundation
import UIKit

extension UIImageView {
    func load(stringURL: String) {
        let url:URL = URL(string: stringURL)!
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
