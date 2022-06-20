//
//  PlaylistsCollectionViewAdapter.swift
//  Task iOS
//
//  Created by Artem Burdak on 19.06.2022.
//

import UIKit

final class PlaylistsCollectionViewAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var eventHandler: EventHandler<Event>
    
    enum Event {
        case didSelectItem(SpotifyPlaylist?)
        case search(String)
        case cancelSearch
    }
    
    private let collectionView: UICollectionView
    
    var playlists: [SpotifyPlaylist]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init(collectionView: UICollectionView, eventHandler: @escaping EventHandler<Event>) {
        self.collectionView = collectionView
        self.eventHandler = eventHandler
        super.init()
        self.configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource  = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        playlists?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PlaylistCollectionViewCell.self)", for: indexPath) as? PlaylistCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: playlists?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        eventHandler(.didSelectItem(playlists?[indexPath.row]))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            var width = CGFloat()
            var size = CGSize()
            width = (collectionView.bounds.width / 2) - 24
            size = CGSize(width: width, height: width)
            return size
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "\(SpotifyHeaderView.self)",
            for: indexPath) as? SpotifyHeaderView else { return UICollectionReusableView() }
        
        headerView.logo.image = UIImage(named: Constants.logo)
        return headerView
    }
}

extension PlaylistsCollectionViewAdapter: UISearchBarDelegate {
//    public func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        filterContentForSearchText(searchBar.text ?? "")
//    }
    
//    func filterContentForSearchText(_ searchText: String) {
//        viewModel.filteredPrivacyGuides = viewModel.privacyAdvisorService.privacyGuides.map {
//            var guide = $0
//            guide.isExpanded = true
//            guide.subguides = guide.subguides.filter {
//                $0.title.lowercased().contains(searchText.lowercased())
//            }
//            return !guide.subguides.isEmpty ? guide : nil
//        }
//        collectionView.reloadData()
//    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        eventHandler(.search(searchBar.text ?? ""))
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        eventHandler(.cancelSearch)
    }
}
