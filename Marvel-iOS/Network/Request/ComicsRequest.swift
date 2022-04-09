//
//  ComicsRequest.swift
//  Marvel-iOS
//
//  Created by Mehmet Emin on 6.04.2022.
//

import Foundation

final class ComicsRequest: APIRequest {

    var body: Data?
    var method: RequestType
    var path: String
    var parameters: [String : String]
    let limit = 10
    let dateRange = "2005-01-01,2022-04-07"
    let orderBy = "onsaleDate"

    init(characterId: Int) {
        self.method = .GET
        self.path = "\(APIConstants.Path.characters)" +
            "/\(characterId)" +
            "\(APIConstants.Path.comics)"
        self.parameters = [
            APIConstants.ParamKeys.dateRange : dateRange,
            APIConstants.ParamKeys.limit : "\(limit)",
            APIConstants.ParamKeys.orderBy : orderBy
        ]
    }
}
