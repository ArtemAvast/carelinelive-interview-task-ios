//
//  PlayerViewModel.swift
//  Task iOS
//
//  Created by Artem Burdak on 20.06.2022.
//

import RxSwift
import RealmSwift

protocol PlayerViewModel {
    var track: SpotifyTrack { get }
    var isPlaying: Bool { get set }
    var isFavourite: Bool { get }

    func getTrackDetails(completion: @escaping (SpotifyAudioFeatures) -> Void)
    func addToFavourites()
    func removeFromFavourites()
}

final class PlayerViewModelImpl: PlayerViewModel {
    var disposeBag: DisposeBag
    let realm = try! Realm()
    lazy var favourites: Results<FavouriteTrack> = { self.realm.objects(FavouriteTrack.self) }()
    
    var track: SpotifyTrack
    var isPlaying: Bool = false
    
    init(disposeBag: DisposeBag, track: SpotifyTrack) {
        self.disposeBag = disposeBag
        self.track = track
    }
    
    var isFavourite: Bool {
        let tracks = realm.objects(FavouriteTrack.self)
        let track = tracks.filter() {
            $0.id == self.track.id
        }
        return (track.first != nil)
    }
    
    func getTrackDetails(completion: @escaping (SpotifyAudioFeatures) -> Void) {
        SpotifyApi.shared.fetchAudioFeatures(id: track.id).subscribe(onNext: { details in
            completion(details)
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)
    }
    
    func addToFavourites() {
        let track = FavouriteTrack(id: self.track.id)
        do {
            try realm.write {
                realm.add(track)
            }
        } catch {
            print("something's wrong")
        }
    }
    
    func removeFromFavourites() {
        let tracks = realm.objects(FavouriteTrack.self)
        let track = tracks.where {
            $0.id == self.track.id
        }
        do {
            try realm.write {
                realm.delete(track)
            }
        } catch {
            print("not in favorites")
        }
    }
}
