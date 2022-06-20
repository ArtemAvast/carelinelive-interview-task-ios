//
//  PlaylistsViewModel.swift
//  Task iOS
//
//  Created by Artem Burdak on 18.06.2022.
//

import Foundation
import RxSwift

protocol PlaylistsViewModel {
    var disposeBag: DisposeBag { get }
    var playlists: [SpotifyPlaylist] { get }
    
    func registerToken(_ completion: @escaping ([SpotifyPlaylist]) -> Void)
    func loadPlaylist(_ completion: @escaping ([SpotifyPlaylist]) -> Void)
    func searchPlaylists(by keyword: String, _ completion: @escaping ([SpotifyPlaylist]) -> Void)
    func selected(playlist: SpotifyPlaylist)
}

final class PlaylistsViewModelImplementation: PlaylistsViewModel {
    var disposeBag: DisposeBag
    
    var playlists: [SpotifyPlaylist] = []
    
    private let eventHandler: EventHandler<Event>

    enum Event {
        case onSearch
        case selectedPlaylist(SpotifyPlaylist)
    }
    
    init(disposeBag: DisposeBag, eventHandler: @escaping EventHandler<Event>) {
        self.disposeBag = disposeBag
        self.eventHandler = eventHandler
    }
    
    func registerToken(_ completion: @escaping ([SpotifyPlaylist]) -> Void) {
        SpotifyApi.shared.loadToken(disposeBag: disposeBag) { [weak self] in
            self?.loadPlaylist(completion)
        }
    }
    
    func loadPlaylist(_ completion: @escaping ([SpotifyPlaylist]) -> Void) {
        SpotifyApi.shared.fetchPlaylists()
            .subscribe { playlists in
            completion(playlists)
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)
    }
    
    func searchPlaylists(by keyword: String, _ completion: @escaping ([SpotifyPlaylist]) -> Void) {
        SpotifyApi.shared.fetchSearch(by: keyword)
            .subscribe { playlists in
                completion(playlists)
            } onError: { error in
                print(error)
            }.disposed(by: disposeBag)

    }
    
    func selected(playlist: SpotifyPlaylist) {
        eventHandler(.selectedPlaylist(playlist))
    }
}
