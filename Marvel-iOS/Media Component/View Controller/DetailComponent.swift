//
//  DetailComponent.swift
//  Marvel-iOS
//
//  Created by Mehmet Emin on 9.04.2022.
//

import UIKit

class DetailComponent: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func prepareForReuse() {
        headerImageView.image = nil
    }
    
    func setup(component: DetailComponentProtocol) {
        self.titleLabel.text = component.output.name
        self.descriptionLabel.text = component.output.description
        guard let url = component.output.imageUrl else {
            headerImageView.image = nil
            return
        }
        self.headerImageView.load(url: url)
    }
    
}
