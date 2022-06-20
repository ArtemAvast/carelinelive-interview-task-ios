//
//  SongTableViewCell.swift
//  Task iOS
//
//  Created by Artem Burdak on 19.06.2022.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    func configure(with track: SpotifyTrack?) {
        if let imageUrl = URL(string: track?.album.images.first?.url ?? "") {
            songImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: Constants.placeholder))
        }
        nameLabel.text = track?.name ?? ""
        artistLabel.text = track?.artists.first?.name ?? ""
    }
}
