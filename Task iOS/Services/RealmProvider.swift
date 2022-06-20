//
// Created by Dec Norton on 10/06/2022.
//

import Foundation
import Realm
import RealmSwift

class RealmProvider {
    static let realm = try! Realm()
}

class FavouriteTrack: Object {
    @Persisted var id = ""
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
}
