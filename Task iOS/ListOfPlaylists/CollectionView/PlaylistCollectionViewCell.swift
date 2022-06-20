//
//  PlaylistCollectionViewCell.swift
//  Task iOS
//
//  Created by Artem Burdak on 19.06.2022.
//

import UIKit
import Kingfisher

class PlaylistCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(with item: SpotifyPlaylist?) {
        if let imageUrl = URL(string: item?.images.first?.url ?? "") {
            imageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: Constants.placeholder))
        }
        nameLabel.text = item?.name ?? ""
        descriptionLabel.text = item?.description ?? ""
    }
}
