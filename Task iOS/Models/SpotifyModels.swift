//
// Created by Dec Norton on 10/06/2022.
//

import Foundation

struct SpotifyTokenResponseBody: Decodable {
    let access_token: String
    let token_type: String
    let expires_in: Int
}

struct SpotifyPlaylist: Decodable {
    let collaborative: Bool;
    let description: String;
    let href: String;
    let id: String;
    let images: Array<SpotifyImage>;
    let name: String;
    let snapshot_id: String;
    let tracks: SpotifyPlaylistTracks;
    let type: String;
    let uri: String;
}

struct SpotifyPlaylistTracks: Decodable {
    let href: String
    let limit: Int
    let offset: Int
    let total: Int
    let items: Array<SpotifyTracksItem>
}

struct SpotifyTracksItem: Decodable {
    let added_at: String
    let track: SpotifyTrack
}

struct SpotifyTrack: Decodable {
    let id: String
    let album: SpotifyAlbum
    let artists: Array<SpotifyArtist>
    let duration_ms: Int
    let explicit: Bool
    let name: String
    let popularity: Int
    let preview_url: String?
    let track: Bool
    let track_number: Int
    let type: String
    let uri: String
}

struct SpotifyAlbum: Decodable {
    let id: String
    let name: String
    let album_type: String
    let release_date: String
    let total_tracks: Int
    let uri: String
    let href: String
    let artists: Array<SpotifyArtist>
    let images: Array<SpotifyImage>
}

struct SpotifyArtist: Decodable {
    let id: String
    let name: String
    let type: String
    let uri: String
    let href: String
}

struct SpotifyImage: Decodable {
    let width: Int?
    let height: Int?
    let url: String
}