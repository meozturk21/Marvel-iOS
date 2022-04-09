//
//  UIImageView+Extension.swift
//  Marvel-iOS
//
//  Created by Mehmet Emin on 9.04.2022.
//

import UIKit
import SDWebImage

extension UIImageView {
    func load(url: URL) {
        self.sd_setImage(with: url)
    }
}
