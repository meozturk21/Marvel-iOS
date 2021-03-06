//
//  ComicsResponse.swift
//  Marvel-iOS
//
//  Created by Mehmet Emin on 6.04.2022.
//

import Foundation
import Realm
import RealmSwift

// MARK: - List Response
struct ComicsListResponse: Codable {
    let code: Int?
    let data: ComicsResponse?
}

// MARK: - Comics Response
struct ComicsResponse: Codable {
    let results: [Comic?]?
    let offset: Int?
    let count: Int?
    let total: Int?
    let limit: Int?
}

// MARK: - Comic
class Comic: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var title: String?
    @objc dynamic var desc: String?
    @objc dynamic var thumbnail: Thumbnail?

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Comic {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case thumbnail = "thumbnail"
        case desc = "description"
    }
}
