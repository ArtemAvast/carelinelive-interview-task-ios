//
//  PlaylistsViewController.swift
//  Task iOS
//
//  Created by Dec Norton on 10/06/2022.
//

import UIKit

final class PlaylistsViewController: BaseViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: PlaylistsViewModel?

    private lazy var adapter = PlaylistsCollectionViewAdapter(collectionView: collectionView) { [weak self] event in
        switch event {
        case .didSelectItem(let item):
            guard let playlist = item else { return }
            self?.viewModel?.selected(playlist: playlist)
        case .search(let searchText):
            self?.viewModel?.searchPlaylists(by: searchText) { [weak self] playlists in
                self?.updateAdapter(with: playlists)
            }
        case .cancelSearch:
            self?.viewModel?.loadPlaylist { [weak self] playlists in
                self?.updateAdapter(with: playlists)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.registerToken { [weak self] playlists in
            self?.adapter.playlists = playlists
        }
        setupSearch()
    }
    
    private func setupSearch() {
        navigationItem.searchController = searchController
        searchController.isActive = true
        searchController.searchBar.delegate = adapter
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.spotifyGreen]
        searchController.searchBar.placeholder = "Search playlists"
        definesPresentationContext = true
    }
    
    private func updateAdapter(with result: [SpotifyPlaylist]) {
        adapter.playlists = result
    }
}

