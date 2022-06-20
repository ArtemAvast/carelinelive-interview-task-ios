//
//  PlaylistDetailsViewController.swift
//  Task iOS
//
//  Created by Artem Burdak on 19.06.2022.
//

import UIKit

final class PlaylistDetailsViewController: BaseViewController {
    @IBOutlet private weak var playlistImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var playlistImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: PlaylistDetailsViewModelImpl?
    
    private lazy var adapter = PlaylistDetailsTableViewAdapter(tableView: tableView) { [weak self] event in
        switch event {
        case .didSelectItem(let item):
            guard let track = item else { return }
            self?.viewModel?.selected(track: track)
        case .scrolledUp:
            self?.viewScrolledUp()
        case .scrolledDown:
            self?.viewScrolledDown()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadPlaylist()
    }
    
    private func setupView() {
        if let imageUrl = URL(string: viewModel?.playlist.images.first?.url ?? "") {
            playlistImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: Constants.placeholder))
        }
        nameLabel.text = viewModel?.playlist.name
        descriptionLabel.text = viewModel?.playlist.description
    }
    
    private func loadPlaylist() {
        self.processingView(isActive: true)
        viewModel?.loadPlaylist { [weak self] tracks in
            self?.adapter.tracks = tracks.tracks.items
            self?.processingView(isActive: false)
        }
    }
    
    private func viewScrolledUp() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.playlistImageViewHeightConstraint.constant = 80
            self?.view.layoutIfNeeded()
        }
    }
    
    private func viewScrolledDown() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.playlistImageViewHeightConstraint.constant = 160
            self?.view.layoutIfNeeded()
        }
    }
}
