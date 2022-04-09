//
//  CharactersListState.swift
//  Marvel-iOS
//
//  Created by Mehmet Emin on 9.04.2022.
//

import Foundation
import RxSwift

enum CharactersListState: Equatable {
    
    case loading
    case loaded
    case nextPage
    case error(_ error: Error)
    
    static func == (lhs: CharactersListState, rhs: CharactersListState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case (.nextPage, .nextPage):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }
}
