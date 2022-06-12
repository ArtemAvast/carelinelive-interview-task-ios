# CareLineLive iOS interview task

This repository contains a barebones iOS application that can authenticate with the [Spotify Web API](https://developer.spotify.com/documentation/web-api/). It serves as an
open-ended starting point for CareLineLive technical tests.

## Task Requirements

As mentioned, this repository is barebones and should be used so you can avoid writing boilerplate networking code. The
following would be expected to be implemented:

- Display details of the playlist; including name, description, and cover image.
- Display a list (or grid) of tracks in the playlist.

## Suggestions

In addition to the above, we'd like to see what you're capable of! You may wish to use the following ideas as a starting
point:

- Allow user to favourite a track; stored locally in a Realm database. Should be visible in the UI on subsequent
  launches.
- [Searching](https://developer.spotify.com/documentation/web-api/reference/#/operations/search) for a different playlist
  - Storing recent searches in a Realm database.
- Fetch and display [audio features](https://developer.spotify.com/documentation/web-api/reference/#/operations/get-several-audio-features)
  for a selected track in an interesting way; such as danceability, tempo, liveness, loudness.

## Configuration

Update `Constants.swift` with the authorization string provided to you.

## App Structure

This is a very basic iOS app with no UI implemented. Please implement the UI using SwiftUI, Storyboards or FlexLayout to
implement the UI. The app has been scaffolded with a storyboard, but feel free to switch to another method.

`SpotifyApi` contains code that will fetch an access token from Spotify using the Client Credentials grant. The token is
not authenticated as a user. The token will be loaded and stored in the `SpotifyApi.token` BehaviorSubject when the app
is launched.

A single method has been added to interact with the API: `fetchPlaylist(id: String)`. It will request a Spotify playlist
from the API and decode into a `SpotifyPlaylist` struct. `ViewController` contains a snippet that fetches a playlist.

## Packages
The project has a number of packages imported via Swift Package Manager ready for use:
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [Realm](https://github.com/realm/realm-swift)
- [RxAlamofire](https://github.com/RxSwiftCommunity/RxAlamofire)
- [RxSwift](https://github.com/ReactiveX/RxSwift)

## Spotify API Reference

- https://developer.spotify.com/documentation/web-api/reference/#/operations/get-playlist
- https://developer.spotify.com/documentation/web-api/reference/#/operations/get-playlists-tracks
- https://developer.spotify.com/documentation/web-api/reference/#/operations/get-several-audio-features

