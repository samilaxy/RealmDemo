//
//  RealmConfig.swift
//  NewRealmDemo
//
//  Created by Samuel on 7/17/24.
//


import Foundation
import RealmSwift

class Todo: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var status: String = ""
    @Persisted var ownerId: String
    
    convenience init(name: String, ownerId: String) {
        self.init()
        self.name = name
        self.ownerId = ownerId
    }
}
