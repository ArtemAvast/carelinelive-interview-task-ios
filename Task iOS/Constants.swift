//
// Created by Dec Norton on 10/06/2022.
//

import Foundation

struct Constants {
    static let spotifyClientAuthorization = "Nzc0ZWE5MjIzYmMwNDljNjgwYmQzMDg1NmNlZGQ3MDc6M2VhZGJjMzYxYmFmNDMzOTgwOWEwY2IzOTQwODUxMDU"
    static let placeholder = "placeholder"
    static let logo = "Spotify_Logo_RGB_Green"
    static let musicAnimation = "musicLoading"
    static let baseUrl = "https://api.spotify.com/v1/"
}

// MARK: Storyboard data
enum StoryboardNames: String {
    case main = "Main"
    
    var description: String {
        return self.rawValue
    }
}
