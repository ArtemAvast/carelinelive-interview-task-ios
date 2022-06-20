//
//  PlaylistDetailsViewModel.swift
//  Task iOS
//
//  Created by Artem Burdak on 19.06.2022.
//

import RxSwift

protocol PlaylistDetailsViewModel {
    var playlist: SpotifyPlaylist { get }
    
    func selected(track: SpotifyTrack)
}

final class PlaylistDetailsViewModelImpl: PlaylistDetailsViewModel {
    var disposeBag: DisposeBag
    
    var playlist: SpotifyPlaylist
    
    private let eventHandler: EventHandler<Event>

    enum Event {
        case selectedTrack(SpotifyTrack)
    }
    
    init(disposeBag: DisposeBag, playlist: SpotifyPlaylist, eventHandler: @escaping EventHandler<Event>) {
        self.disposeBag = disposeBag
        self.playlist = playlist
        self.eventHandler = eventHandler
    }
    
    func loadPlaylist(_ completion: @escaping (SpotifyPlaylist) -> Void) {
        SpotifyApi.shared.fetchPlaylist(id: playlist.id)
            .subscribe(onNext: { playlist in
                completion(playlist)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    func selected(track: SpotifyTrack) {
        eventHandler(.selectedTrack(track))
    }
    
}
