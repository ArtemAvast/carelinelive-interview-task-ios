//
//  SpotifyApi.swift
//  Task iOS
//
//  Created by Dec Norton on 10/06/2022.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

final class SpotifyApi {
    static let shared = SpotifyApi()
    var token1 = ""
    let token = BehaviorSubject<String?>(value: nil)

    func loadToken(disposeBag: DisposeBag, completion: @escaping () -> Void) {
        self.fetchToken().subscribe(onNext: { token in
            self.token.on(.next(token))
            self.token1 = token
            completion()
        }).disposed(by: disposeBag)
    }

    private func fetchToken() -> Observable<String> {
        let parameters = ["grant_type": "client_credentials"]
        let headers: HTTPHeaders = [
            HTTPHeader(name: "Content-Type", value: "application/x-www-form-urlencoded"),
            HTTPHeader(name: "Authorization", value: "Basic " + Constants.spotifyClientAuthorization)
        ]
        return requestDecodable(
            .post,
            "https://accounts.spotify.com/api/token",
            parameters: parameters,
            headers: headers
        )
        .observeOn(MainScheduler.instance)
        .map { (response: HTTPURLResponse, body: SpotifyTokenResponseBody) in
            body.access_token
        }
    }

    func fetchPlaylist(id: String) -> Observable<SpotifyPlaylist> {
        self.token
            .compactMap { $0 }
            .flatMap { token -> Observable<SpotifyPlaylist> in
                requestDecodable(
                    .get,
                    Constants.baseUrl + "playlists/\(id)",
                    headers: [
                        HTTPHeader(name: "Authorization", value: "Bearer " + token)
                    ]
                ).map { (response: HTTPURLResponse, body: SpotifyPlaylist) in
                    body
                }
            }
    }
    
    func fetchAudioFeatures(id: String) -> Observable<SpotifyAudioFeatures> {
        self.token
            .compactMap { $0 }
            .flatMap { token -> Observable<SpotifyAudioFeatures> in
                requestDecodable(
                    .get,
                    Constants.baseUrl + "audio-features/\(id)",
                    headers: [
                        HTTPHeader(name: "Authorization", value: "Bearer " + token)
                    ]
                ).map { (response: HTTPURLResponse, body: SpotifyAudioFeatures) in
                    body
                }
            }
    }
    
    func fetchSearch(by keyWord: String) -> Observable<[SpotifyPlaylist]> {
        self.token
            .compactMap { $0 }
            .flatMap { token -> Observable<[SpotifyPlaylist]> in
                requestDecodable(
                    .get,
                    Constants.baseUrl + "search?q=\(keyWord)&type=playlist&limit=50",
                    headers: [
                        HTTPHeader(name: "Authorization", value: "Bearer " + token)
                    ]
                ).map { (response: HTTPURLResponse, body: SpotifyFeaturedPlaylistsResponseBody) in
                    body.playlists.items
                }
            }
    }

    func fetchPlaylists() -> Observable<[SpotifyPlaylist]> {
        self.token
            .compactMap { $0 }
            .flatMap { token -> Observable<[SpotifyPlaylist]> in
                requestDecodable(
                    .get,
                    Constants.baseUrl + "browse/featured-playlists",
                    headers: [
                        HTTPHeader(name: "Authorization", value: "Bearer " + token)
                    ]
                ).map { (response: HTTPURLResponse, body: SpotifyFeaturedPlaylistsResponseBody) in
                    body.playlists.items
                }
            }
    }
    
//    func loadPlayslists(_ completion: @escaping ([SpotifyPlaylist]) -> Void) { // I thought I should implement one request without rx to show you not only my copy-pasting skills
//        guard let url = URL(string: Constants.baseUrl + "browse/featured-playlists") else { return }
//        AF.request(url, method: .get, encoding: URLEncoding.default, headers: [HTTPHeader(name: "Authorization", value: "Bearer " + (token1))]).responseString { response in
//            if let data = response.data, let response = try? JSONDecoder().decode(SpotifyFeaturedPlaylistsResponseBody.self, from: data) {
//                completion(response.playlists.items)
//            }
//        }
//    }
}
