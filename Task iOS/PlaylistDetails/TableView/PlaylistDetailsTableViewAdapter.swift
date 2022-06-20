//
//  PlaylistDetailsTableViewAdapter.swift
//  Task iOS
//
//  Created by Artem Burdak on 19.06.2022.
//

import UIKit

final class PlaylistDetailsTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    private var eventHandler: EventHandler<Event>
    
    enum Event {
        case scrolledDown
        case scrolledUp
        case didSelectItem(SpotifyTrack?)
    }
    
    private let tableView: UITableView
    
    var tracks: [SpotifyTracksItem]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(tableView: UITableView, eventHandler: @escaping EventHandler<Event>) {
        self.tableView = tableView
        self.eventHandler = eventHandler
        super.init()
        self.configureCollectionView()
    }
    
    private func configureCollectionView() {
        tableView.delegate = self
        tableView.dataSource  = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SongTableViewCell.self)", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        cell.configure(with: tracks?[indexPath.row].track)
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventHandler(.didSelectItem(tracks?[indexPath.row].track))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if translation.y < 0 {
            eventHandler(.scrolledUp)
        } else {
            eventHandler(.scrolledDown)
        }
    }
}
