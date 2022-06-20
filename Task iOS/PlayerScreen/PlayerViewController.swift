//
//  PlayerViewController.swift
//  Task iOS
//
//  Created by Artem Burdak on 19.06.2022.
//

import UIKit
import Lottie

final class PlayerViewController: BaseViewController {
    @IBOutlet private weak var playerImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var albumLabel: UILabel!
    @IBOutlet private weak var favouriteButton: UIButton!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet weak var danceabilityLabel: UILabel!
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var livenessLabel: UILabel!
    
    var viewModel: PlayerViewModel!
    
    private var animationView: AnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimation()
        setupView()
        viewModel.getTrackDetails { [weak self] details in
            self?.setupDetails(trackDetails: details)
        }
    }
    
    private func setupView() {
        nameLabel.text = viewModel?.track.name
        albumLabel.text = viewModel?.track.album.name
        playButton.layer.cornerRadius = playButton.frame.height / 2
        favouriteButton.isSelected = viewModel.isFavourite
    }
    
    private func setupDetails(trackDetails: SpotifyAudioFeatures) {
        danceabilityLabel.text = countEmojis(emoji: " 💃 ", value: trackDetails.danceability)
        energyLabel.text = countEmojis(emoji: " ⚡️ ", value: trackDetails.energy)
        livenessLabel.text = countEmojis(emoji: " 🎭 ", value: trackDetails.liveness)
    }
    
    private func configureAnimation() {
        let jsonName = Constants.musicAnimation
        let animation = Animation.named(jsonName)
        animationView = AnimationView(animation: animation)
        animationView?.frame = playerImageView.bounds
        animationView?.loopMode = .autoReverse
        playerImageView.addSubview(animationView ?? UIView())
    }
    
    @IBAction func favourite(_ sender: UIButton) {
        favouriteButton.isSelected.toggle()
        favouriteButton.isSelected ? viewModel.addToFavourites() : viewModel.removeFromFavourites()
    }
    
    @IBAction func play(_ sender: UIButton) {
        viewModel.isPlaying ? animationView?.pause() : animationView?.play()
        viewModel.isPlaying.toggle()
        playButton.isSelected.toggle()
    }
    
    private func countEmojis(emoji: String, value: Float) -> String {
        var newValue = value
        var emojiString = ""
        repeat {
            emojiString += emoji
            newValue -= 0.1
        } while newValue - 0.1 >= 0
        return emojiString
    }
}
