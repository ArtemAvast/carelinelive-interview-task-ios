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

class SpotifyApi {
    static let shared = SpotifyApi()

    let token = BehaviorSubject<String?>(value: nil)

    private init() {
    }

    func loadToken() {
        self.fetchToken().subscribe(onNext: { token in
            self.token.on(.next(token))
        })
    }

    private func fetchToken() -> Observable<String> {
        let parameters = ["grant_type": "client_credentials"]

        let headers: HTTPHeaders = [
            HTTPHeader(name: "Content-Type", value: "application/x-www-form-urlencoded"),
            HTTPHeader(name: "Authorization", value: "Basic " + Constants.spotifyClientAuthorization.rawValue)
        ]

        return requestDecodable(
            .post,
            "https://accounts.spotify.com/api/token",
            parameters: parameters,
            headers: headers
        )
                .observe(on: MainScheduler.instance)
                .map { (response: HTTPURLResponse, body: SpotifyTokenResponseBody) in
                    body.access_token
                }
    }

    func fetchPlaylist(id: String) -> Observable<SpotifyPlaylist> {
        // Use the result of the `token` BehaviorSubject
        self.token
                // Make sure the token isn't nil (ie. the initial value)
                .compactMap { $0 }
                // Swap the observable
                .flatMap { token -> Observable<SpotifyPlaylist> in
                    // Make a request to the API and decode it as a SpotifyPlaylist struct
                    requestDecodable(
                        .get,
                        "https://api.spotify.com/v1/playlists/\(id)",
                        headers: [
                            HTTPHeader(name: "Authorization", value: "Bearer " + token)
                        ]
                    ).map { (response: HTTPURLResponse, body: SpotifyPlaylist) in
                        body
                    }
                }
    }
}
